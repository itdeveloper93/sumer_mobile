import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sumer_mobile/global.dart';
import 'package:sumer_mobile/model/employee_passport.dart';
import 'package:sumer_mobile/services/auth_service.dart';
import 'package:http/http.dart' as http;

class EmployeePassportData extends StatefulWidget {
  final String id;
  EmployeePassportData(this.id);

  _EmployeePassportDataState createState() => _EmployeePassportDataState(id);
}

class _EmployeePassportDataState extends State<EmployeePassportData> {
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
      URL + "api/Employees/PassportData/" + id,
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
            elevation: 0,
            child: Container(
              padding: EdgeInsets.only(top: 7),
              child: Column(
                children: <Widget>[
                  ListTile(
                      title: Text('Серия и номер: '),
                      trailing: Text(snapshot.data.passportNumber != null
                          ? snapshot.data.passportNumber
                          : '')),
                  Divider(
                    color: Colors.black26,
                  ),
                  ListTile(
                    title: Text('Орган, выдавший паспорт: '),
                    trailing: Text(snapshot.data.passportIssuer != null
                        ? snapshot.data.passportIssuer
                        : ''),
                  ),
                  Divider(
                    color: Colors.black26,
                  ),
                  ListTile(
                    title: Text('Дата выдачи: '),
                    trailing: Text(snapshot.data.passportIssueDate != null
                        ? snapshot.data.passportIssueDate
                        : ''),
                  ),
                  Divider(
                    color: Colors.black26,
                  ),
                  ListTile(
                    title: Text('Национальность: '),
                    trailing: Text(snapshot.data.nationality != null
                        ? snapshot.data.nationality
                        : ''),
                  ),
                  Divider(
                    color: Colors.black26,
                  ),
                  ListTile(
                    title: Text('Дата рождения: '),
                    trailing: Text(snapshot.data.dateOfBirth != null
                        ? snapshot.data.dateOfBirth
                        : ''),
                  ),
                  Divider(
                    color: Colors.black26,
                  ),
                  ListTile(
                    title: Text('Прописка: '),
                    trailing: Text(snapshot.data.passportAddress != null
                        ? snapshot.data.passportAddress
                        : ''),
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
}
