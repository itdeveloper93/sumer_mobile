import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:SAMR/global.dart';
import 'package:SAMR/model/employee_passport.dart';
import 'package:SAMR/services/auth_service.dart';
import 'package:http/http.dart' as http;

class EmployeePassportData extends StatefulWidget {
  final String id;
  EmployeePassportData(this.id);

  _EmployeePassportDataState createState() => _EmployeePassportDataState(id);
}

class _EmployeePassportDataState extends State<EmployeePassportData>
    with AutomaticKeepAliveClientMixin<EmployeePassportData> {
  String id;
  _EmployeePassportDataState(this.id);
  Future<EmployeePassport> _employeePassportData;
  @override
  void initState() {
    super.initState();
    _employeePassportData = _loadEmployeePassportData(id);
  }

  Future<EmployeePassport> _loadEmployeePassportData(String id) async {
    final response = await http.get(
      url + "api/Employees/PassportData/" + id,
      // Send authorization headers to the backend.
      headers: await AuthService.addAuthTokenToRequest(),
    );

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      return EmployeePassport.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<EmployeePassport>(
      future: _employeePassportData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Card(
            semanticContainer: true,
            elevation: 0,
            child: Container(
              padding: EdgeInsets.only(top: 5),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 50,
                    child: ListTile(
                        title: Text('Серия и номер: '),
                        trailing: Text(snapshot.data.passportNumber != null
                            ? snapshot.data.passportNumber
                            : '')),
                  ),
                  Divider(
                    color: Colors.black26,
                  ),
                  Container(
                    transform: Matrix4.translationValues(0, -7, 0),
                    height: 40,
                    child: ListTile(
                      title: Text('Орган, выдавший паспорт: '),
                      trailing: Text(snapshot.data.passportIssuer != null
                          ? snapshot.data.passportIssuer
                          : ''),
                    ),
                  ),
                  Divider(
                    color: Colors.black26,
                  ),
                  Container(
                    transform: Matrix4.translationValues(0, -7, 0),
                    height: 40,
                    child: ListTile(
                      title: Text('Дата выдачи: '),
                      trailing: Text(snapshot.data.passportIssueDate != null
                          ? snapshot.data.passportIssueDate
                          : ''),
                    ),
                  ),
                  Divider(
                    color: Colors.black26,
                  ),
                  Container(
                    transform: Matrix4.translationValues(0, -7, 0),
                    height: 40,
                    child: ListTile(
                      title: Text('Национальность: '),
                      trailing: Text(snapshot.data.nationality != null
                          ? snapshot.data.nationality
                          : ''),
                    ),
                  ),
                  Divider(
                    color: Colors.black26,
                  ),
                  Container(
                    transform: Matrix4.translationValues(0, -7, 0),
                    height: 40,
                    child: ListTile(
                      title: Text('Дата рождения: '),
                      trailing: Text(snapshot.data.dateOfBirth != null
                          ? snapshot.data.dateOfBirth
                          : ''),
                    ),
                  ),
                  Divider(
                    color: Colors.black26,
                  ),
                  Container(
                    transform: Matrix4.translationValues(0, -7, 0),
                    height: 40,
                    child: ListTile(
                      title: Text('Прописка: '),
                      trailing: Text(snapshot.data.passportAddress != null
                          ? snapshot.data.passportAddress
                          : ''),
                    ),
                  ),
                ],
              ),
            ),
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
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
