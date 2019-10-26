import 'package:SAMR/administration/employees/active_employees_list.dart';
import 'package:SAMR/dashboard/desktop/last_news.dart';
import 'package:SAMR/requests/employees_request.dart';
import 'package:SAMR/requests/news_request.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:SAMR/authorization/login.dart';

import 'package:SAMR/dashboard/global_drawer.dart';
import 'package:SAMR/dashboard/global_appBar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int employeesTotalCount;
  int newsTotalCount;
  Widget lastnews;
  bool onlyUsers = true;
  @override
  void initState() {
    checkLoginStatus();
    setState(() {
      onlyUsers = true;
    });
    super.initState();
  }

  checkLoginStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    if (token == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
      return;
    }
    EmployeesRequest().loadEmployees().then((value) {
      setState(() {
        employeesTotalCount = value;
      });
    });
    NewsRequest().loadUsersTotalCount().then((value) {
      setState(() {
        newsTotalCount = value;
      });
    });
    lastnews = LastNewsListTitle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f7f8),
      drawer: GlobalDrawer(),
      appBar: GlobalAppBar(
        title: Container(
          transform: Matrix4.translationValues(-20, 1, 0),
          child: Text(
            'Рабочий стол',
            style: TextStyle(
                color: Color(0xFF293148),
                fontFamily: "Roboto",
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ActiveEmployeesList(null),
                    ),
                  );
                },
                child: Container(
                  width: 200,
                  child: Card(
                    margin: EdgeInsets.only(
                      top: 10,
                      left: 13,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          alignment: Alignment.bottomRight,
                          image: ExactAssetImage('assets/contact_calendar.png'),
                        ),
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              'СОТРУДНИКОВ',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff465179),
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              employeesTotalCount == null
                                  ? ''
                                  : employeesTotalCount.toString(),
                              style: TextStyle(
                                fontSize: 40,
                                color: Color(0xff858ca1),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Посмотреть всех',
                                  style: TextStyle(
                                    color: Color(0xff858ca2),
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Color(0xff858ca2),
                                  size: 15,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ActiveEmployeesList(onlyUsers),
                    ),
                  );
                },
                child: Container(
                  width: 200,
                  child: Card(
                    margin: EdgeInsets.only(
                      top: 10,
                      right: 13,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          alignment: Alignment.bottomRight,
                          image: ExactAssetImage('assets/library_book.png'),
                        ),
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              'ПОЛЬЗОВАТЕЛЕЙ',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff465179),
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              newsTotalCount == null
                                  ? ''
                                  : newsTotalCount.toString(),
                              style: TextStyle(
                                fontSize: 40,
                                color: Color(0xff858ca1),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Посмотреть всех',
                                  style: TextStyle(
                                    color: Color(0xff858ca2),
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Color(0xff858ca2),
                                  size: 15,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(height: 525, child: lastnews),
        ],
      ),
    );
  }
}
