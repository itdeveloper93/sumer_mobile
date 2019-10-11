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
  bool isLoading = false;

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
    super.initState();
    _employee = _loadEmployee(id);
    controller = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  TabBarView headerSection() {
    return TabBarView(
      controller: controller,
      children: [
        Center(
          child: Text('Hello'),
        ),
        Center(
          child: Text('Hi'),
        ),
      ],
    );
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
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundImage:
                                  NetworkImage(snapshot.data.photoPathSmall),
                              backgroundColor: Colors.blueAccent,
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
                          TabBar(controller: controller, tabs: <Tab>[
                            Tab(
                              child: Text(
                                'Главное',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Паспортные данные',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ])
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 720,
                    child: new TabBarView(
                      controller: controller,
                      children: <Widget>[
                        Card(
                          elevation: 0,
                          child: Container(
                            padding: EdgeInsets.only(top: 7),
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  title: Text('Дата рождения: '),
                                  trailing: Text(snapshot.data.dateOfBirth),
                                ),
                                Divider(
                                  color: Colors.black26,
                                ),
                                ListTile(
                                  title: Text('Отдел: '),
                                  trailing: Text(snapshot.data.department),
                                ),
                                Divider(
                                  color: Colors.black26,
                                ),
                                ListTile(
                                  title: Text('Позиция: '),
                                  trailing: Text(snapshot.data.position),
                                ),
                                Divider(
                                  color: Colors.black26,
                                ),
                                ListTile(
                                  title: Text('Дата приема на работу: '),
                                  trailing: Text(snapshot.data.hireDate),
                                ),
                                Divider(
                                  color: Colors.black26,
                                ),
                                ListTile(
                                  title: Text('Телефон: '),
                                  trailing: Text(snapshot.data.phone),
                                ),
                                Divider(
                                  color: Colors.black26,
                                ),
                                ListTile(
                                  title: Text('Email: '),
                                  trailing: Text(snapshot.data.email),
                                ),
                                Divider(
                                  color: Colors.black26,
                                ),
                                ListTile(
                                  title: Text('Фактический адрес: '),
                                  trailing: Text(snapshot.data.factualAddress),
                                ),
                                Divider(
                                  color: Colors.black26,
                                ),
                                ListTile(
                                  title: Text('Пол: '),
                                  trailing: Text(snapshot.data.genderName),
                                ),
                                Divider(
                                  color: Colors.black26,
                                ),
                                ListTile(
                                  title: Text('Дополнительное описание: '),
                                  subtitle: Text(snapshot.data.description),
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
