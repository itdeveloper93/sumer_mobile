import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sumer_mobile/authorization/login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences sharedPreferences;
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.apps, color: Colors.blueAccent[700]),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        // leading: IconButton(
        //   icon: Icon(Icons.apps,
        //       color: Colors.blueAccent[700]), // set your color here
        //   onPressed: () {
        //     _scaffoldKey.currentState.openDrawer();
        //   },
        // ),
        backgroundColor: Color(0xFFFFFFFF),
        // title: Image.asset(
        //   'assets/company-logo.png',
        //   height: 30,
        // ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 6),
            child: Padding(
              padding: EdgeInsets.all(11),
              child: Image.asset(
                'assets/company-logo.png',
              ),
            ),
          )
        ],
      ),
      body: Center(child: Text("Dashboard")),
      drawer: Drawer(
        child: Container(
          color: Color(0xFF293147),
          child: Column(children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: Text(
                      "Iskandar Mirzoev",
                      style: TextStyle(
                        color: Color(0xFFd2d7e8),
                        fontSize: 17,
                      ),
                    ),
                    accountEmail: Text(
                      "Mobile Developer",
                      style: TextStyle(
                        color: Color(0xFF868FA5),
                        fontSize: 12,
                      ),
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://www.outerplaces.com/media/k2/items/cache/694f682377d0e66514a01a87bb9e4fb5_L.jpg'),
                      backgroundColor: Colors.transparent,
                    ),
                    decoration: BoxDecoration(color: Color(0xFF323C58)),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.archive,
                      color: Color(0xFFd2d7e8),
                    ),
                    title: Text(
                      'Сообщения',
                      style: TextStyle(
                        color: Color(0xFFd2d7e8),
                      ),
                    ),
                    trailing: Text(
                      '15',
                      style: TextStyle(color: Color(0xFFd2d7e8)),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.desktop_windows,
                      color: Color(0xFFd2d7e8),
                    ),
                    title: Text(
                      'Рабочий стол',
                      style: TextStyle(
                        color: Color(0xFFd2d7e8),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.library_books,
                      color: Color(0xFFd2d7e8),
                    ),
                    title: Text(
                      'Новости и информация',
                      style: TextStyle(
                        color: Color(0xFFd2d7e8),
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_right,
                      color: Color(0xFFd2d7e8),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.view_list,
                      color: Color(0xFFd2d7e8),
                    ),
                    title: Text(
                      'Справочники',
                      style: TextStyle(
                        color: Color(0xFFd2d7e8),
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_right,
                      color: Color(0xFFd2d7e8),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.settings_input_component,
                      color: Color(0xFFd2d7e8),
                    ),
                    title: Text(
                      'Администрирование',
                      style: TextStyle(
                        color: Color(0xFFd2d7e8),
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_right,
                      color: Color(0xFFd2d7e8),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                child: Column(
              children: <Widget>[
                Divider(),
                ListTile(
                  leading: const Icon(
                    Icons.help,
                    color: Color(0xFFd2d7e8),
                  ),
                  title: Text(
                    'Помощь',
                    style: TextStyle(
                      color: Color(0xFFd2d7e8),
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    sharedPreferences.clear();
                    // sharedPreferences.commit();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => LoginPage()),
                        (Route<dynamic> route) => false);
                  },
                  leading: const Icon(
                    Icons.exit_to_app,
                    color: Color(0xFFd2d7e8),
                  ),
                  title: Text(
                    'Выйти из системы',
                    style: TextStyle(
                      color: Color(0xFFd2d7e8),
                    ),
                  ),
                ),
              ],
            ))
          ]),
        ),
      ),
    );
  }
}
