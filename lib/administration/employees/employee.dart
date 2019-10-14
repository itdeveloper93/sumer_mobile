import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sumer_mobile/administration/employees/employee_passport.dart';
import 'package:sumer_mobile/services/auth_service.dart';

import 'package:sumer_mobile/dashboard/global_appBar.dart';
import 'package:sumer_mobile/dashboard/global_drawer.dart';
import 'package:sumer_mobile/global.dart';
import 'package:sumer_mobile/model/employee.dart' as employeeFields;

class Employee extends StatefulWidget {
  final String id;
  Employee(this.id);
  @override
  _EmployeeState createState() => _EmployeeState(id);
}

class _EmployeeState extends State<Employee>
    with SingleTickerProviderStateMixin {
  Future<employeeFields.Employee> _employee;
  String id;
  _EmployeeState(this.id);
  bool isLoading = false; // To control switching tabs
  ScrollController _scrollViewController; // To control scrolling

  Future<employeeFields.Employee> _loadEmployee(String id) async {
    final response = await http.get(
      URL + "api/Employees/" + id,
      // Send authorization headers to the backend.
      headers: await AuthService.addAuthTokenToRequest(),
    );

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      return employeeFields.Employee.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  @override
  void initState() {
    _employee = _loadEmployee(this.id);
    print(this.id);
    controller = TabController(
      length: 2,
      vsync: this,
    );
    _scrollViewController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }

  TabController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f7f8),
      drawer: GlobalDrawer(),
      appBar: GlobalAppBar(
        title: Container(
          transform: Matrix4.translationValues(-20, 1, 0),
          child: Text(
            'Edit User Info',
            style: TextStyle(
                color: Color(0xFF293148),
                fontFamily: "Roboto",
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: FutureBuilder<employeeFields.Employee>(
          future: _employee,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: <Widget>[
                  Container(
                    child: Card(
                      elevation: 0,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                              bottom: 20,
                            ),
                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.only(
                              top: 30,
                            ),
                            child: Container(
                              width: 120,
                              height: 120,
                              child: ClipOval(
                                child: FadeInImage.assetNetwork(
                                  fit: BoxFit.cover,
                                  placeholder: 'assets/noavatar.jpg',
                                  image: snapshot.data.photoPathSmall,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                            child: Text(
                              snapshot.data.fullName,
                              style: TextStyle(
                                color: Color(0xFF293148),
                                fontFamily: "Roboto",
                                fontSize: 19.6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 30),
                            child: Text(
                              snapshot.data.department +
                                  ' › ' +
                                  snapshot.data.position,
                              style: TextStyle(
                                color: Color(0xFF858CA2),
                                fontFamily: "Roboto",
                                fontSize: 14,
                              ),
                            ),
                          ),
                          TabBar(
                              controller: controller,
                              indicatorColor: Color(0xFF4f3af1),
                              tabs: <Tab>[
                                Tab(
                                  child: Text(
                                    'Главное',
                                    style: TextStyle(color: Color(0xFF848895)),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    'Паспортные данные',
                                    style: TextStyle(color: Color(0xFF848895)),
                                  ),
                                ),
                              ])
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 550,
                    child: TabBarView(
                      controller: controller,
                      children: <Widget>[
                        Card(
                          elevation: 0,
                          child: Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 50,
                                  child: ListTile(
                                    title: Text('Дата рождения '),
                                    trailing: Text(
                                      snapshot.data.dateOfBirth != null
                                          ? snapshot.data.dateOfBirth
                                          : '',
                                      style:
                                          TextStyle(color: Color(0xFF9096a9)),
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.black26,
                                ),
                                Container(
                                  transform:
                                      Matrix4.translationValues(0, -7, 0),
                                  height: 40,
                                  child: ListTile(
                                    title: Text('Отдел '),
                                    trailing: Text(
                                      snapshot.data.department != null
                                          ? snapshot.data.department
                                          : '',
                                      style:
                                          TextStyle(color: Color(0xFF9096a9)),
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.black26,
                                ),
                                Container(
                                  transform:
                                      Matrix4.translationValues(0, -7, 0),
                                  height: 40,
                                  child: ListTile(
                                    title: Text('Позиция '),
                                    trailing: Text(
                                      snapshot.data.position != null
                                          ? snapshot.data.position
                                          : '',
                                      style:
                                          TextStyle(color: Color(0xFF9096a9)),
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.black26,
                                ),
                                Container(
                                  transform:
                                      Matrix4.translationValues(0, -7, 0),
                                  height: 40,
                                  child: ListTile(
                                    title: Text('Дата приема на работу '),
                                    trailing: Text(
                                      snapshot.data.hireDate != null
                                          ? snapshot.data.hireDate
                                          : '',
                                      style:
                                          TextStyle(color: Color(0xFF9096a9)),
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.black26,
                                ),
                                Container(
                                  transform:
                                      Matrix4.translationValues(0, -7, 0),
                                  height: 40,
                                  child: ListTile(
                                    title: Text('Телефон '),
                                    trailing: Text(
                                      snapshot.data.phone != null
                                          ? snapshot.data.phone
                                          : '',
                                      style:
                                          TextStyle(color: Color(0xFF9096a9)),
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.black26,
                                ),
                                Container(
                                  transform:
                                      Matrix4.translationValues(0, -7, 0),
                                  height: 40,
                                  child: ListTile(
                                    title: Text('Email '),
                                    trailing: Text(
                                      snapshot.data.email != null
                                          ? snapshot.data.email
                                          : '',
                                      style:
                                          TextStyle(color: Color(0xFF9096a9)),
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.black26,
                                ),
                                Container(
                                  transform:
                                      Matrix4.translationValues(0, -7, 0),
                                  height: 40,
                                  child: ListTile(
                                    title: Text('Фактический адрес '),
                                    trailing: Text(
                                      snapshot.data.factualAddress != null
                                          ? snapshot.data.factualAddress
                                          : '',
                                      style:
                                          TextStyle(color: Color(0xFF9096a9)),
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.black26,
                                ),
                                Container(
                                  transform:
                                      Matrix4.translationValues(0, -7, 0),
                                  height: 40,
                                  child: ListTile(
                                    title: Text('Пол '),
                                    trailing: Text(
                                      snapshot.data.genderName != null
                                          ? snapshot.data.genderName
                                          : '',
                                      style:
                                          TextStyle(color: Color(0xFF9096a9)),
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.black26,
                                ),
                                Container(
                                  transform:
                                      Matrix4.translationValues(0, -7, 0),
                                  height: 40,
                                  child: ListTile(
                                    title: Text('Дополнительное описание '),
                                    subtitle: Text(
                                      snapshot.data.description != null
                                          ? snapshot.data.description
                                          : '',
                                      style:
                                          TextStyle(color: Color(0xFF9096a9)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        EmployeePassportData(id),
                      ],
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blueAccent,
              ),
            );
          },
        ),
      ),
    );
  }
}
