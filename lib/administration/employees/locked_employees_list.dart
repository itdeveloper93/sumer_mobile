import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:SAMR/administration/employees/employee.dart';
import 'package:SAMR/dashboard/global_appBar.dart';
import 'package:SAMR/dashboard/global_drawer.dart';
import 'package:SAMR/global.dart';
import 'package:SAMR/model/departments_select_list.dart';
import 'package:SAMR/model/employees.dart';
import 'package:http/http.dart' as http;
import 'package:SAMR/services/auth_service.dart';

class LockedEmployeesList extends StatefulWidget {
  @override
  _LockedEmployeesListState createState() => _LockedEmployeesListState();
}

class _LockedEmployeesListState extends State<LockedEmployeesList> {
  List<LockedEmployees> _employees = [];
  List<DepartmentsSelectList> _departments = [];
  // List<DepartmentsSelectList> _departments = List();

  bool isLoading;
  bool switchOn = false;

  void _onSwitchChanged(bool value) {
    switchOn = true;
  }

  @override
  void initState() {
    _loadLockedEmployees();
    this._loadDepartmentsSelectList();
    super.initState();
  }

  Future<void> _loadLockedEmployees() async {
    isLoading = false;
    http.Response response = await http.get(
      url +
          'api/Employees/Locked?fullName=${fullNameController.text}&departmentId=${currentSelectedValue}&onlyUsers=${switchOn}',
      // Send authorization headers to the backend.
      headers: await AuthService.addAuthTokenToRequest(),
    );
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      setState(() {
        _employees = LockedEmployees.allFromResponse(response.body);
      });
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<void> _loadDepartmentsSelectList() async {
    http.Response response = await http.get(
      url + 'api/Departments/SelectListItems',
      // Send authorization headers to the backend.
      headers: await AuthService.addAuthTokenToRequest(),
    );

    setState(() {
      _departments = DepartmentsSelectList.allFromResponse(response.body);
    });
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return AnimatedPadding(
            padding: MediaQuery.of(context).viewInsets,
            duration: const Duration(milliseconds: 100),
            curve: Curves.decelerate,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 25),
              child: Wrap(
                children: <Widget>[
                  textSection(),
                  buttonSection(),
                ],
              ),
            ),
          );
        });
  }

  Row buttonSection() {
    return Row(
      mainAxisSize: MainAxisSize
          .min, // this will take space as minimum as posible(to center)
      children: <Widget>[
        ButtonTheme(
          minWidth: 174.0,
          height: 60.0,
          child: RaisedButton(
            onPressed:
                // emailController.text == "" || factualAddressController.text == ""
                //     ? null
                //     :
                () {
              setState(() {
                isLoading = true;
              });
              _loadLockedEmployees();
              Navigator.pop(context);
            },
            elevation: 0.0,
            color: Colors.indigoAccent[700],
            child: Text("Найти", style: TextStyle(color: Colors.white)),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        ButtonTheme(
          minWidth: 174.0,
          height: 60.0,
          child: RaisedButton(
            onPressed:
                // emailController.text == "" || factualAddressController.text == ""
                //     ? null
                //     :
                () {
              setState(() {
                isLoading = true;
              });
              _loadLockedEmployees();

              // Navigator.pop(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => LockedEmployeesList()));
            },
            elevation: 0.0,
            color: Color(0xFFecf0f5),
            child: Text("Сбросить", style: TextStyle(color: Color(0xFF888fa3))),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
      ],
    );
  }

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController factualAddressController =
      TextEditingController();

  var currentSelectedValue;
  var fullName;
  var onlyUser;
  // static var deviceTypes = [];

  Widget _buildDepartmentDropdown() {
    return Container(
      padding: EdgeInsets.only(bottom: 15),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0))),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: Text("Отдел"),
                value: currentSelectedValue,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    currentSelectedValue = newValue;
                  });
                  print(currentSelectedValue);
                },
                items: _departments.map((item) {
                  return DropdownMenuItem(
                    child: Text(item.name),
                    value: item.id.toString(),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  Container textSection() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: TextFormField(
              controller: fullNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'ФИО',
              ),
            ),
          ),
          _buildDepartmentDropdown(),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: ListTile(
              title: Container(
                transform: Matrix4.translationValues(-13, 0, 0),
                child: Text('Только пользователи'),
              ),
              trailing: Container(
                transform: Matrix4.translationValues(22, 0, 0),
                child: Switch(
                  activeColor: Colors.blueAccent,
                  onChanged: _onSwitchChanged,
                  value: switchOn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeesListTile(BuildContext context, int index) {
    var employee = _employees[index];

    return Card(
      margin: EdgeInsets.only(top: 10, right: 10, left: 10),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => Employee(employee.id),
              ),
            );
          },
          // _navigateToFriendDetails(employee, index),

          title: Text(employee.fullName.toString()),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 3),
                child: Text(employee.department.toString() +
                    ' › ' +
                    employee.position.toString()),
              ),
              Container(
                child: Text('Дата приема: ' + employee.hireDate.toString()),
              ),
              Container(
                child: Text('Дата блокировки: ' + employee.lockDate.toString()),
              ),
              Container(
                child: Text(employee.lockReason.toString()),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCircularProgressIndicator(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (_employees.isEmpty) {
      content = Center(
        child: Text('No Data exist!'),
      );
    } else {
      content = ListView.builder(
        itemCount: _employees.length,
        itemBuilder: _buildEmployeesListTile,
      );
    }

    return Scaffold(
      backgroundColor: Color(0xfff4f7f8),
      drawer: GlobalDrawer(),
      appBar: GlobalAppBar(
        title: Container(
          transform: Matrix4.translationValues(-20, 1, 0),
          child: Text(
            'Заблокированные сотрудники',
            style: TextStyle(
                color: Color(0xFF293148),
                fontFamily: "Roboto",
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: content,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: Icon(
          Icons.filter_list,
          color: Colors.white,
        ),
        onPressed: () {
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (BuildContext context) => EditUserInfo(),
          //   ),
          // );
          // (Route<dynamic> route) => false);
          _settingModalBottomSheet(context);
        },
      ),
    );
  }

  submit(String email, factualAddress) async {
    Map data = {
      'email': email,
      'factualAddress': factualAddress,
    };
    var jsonResponse;
    var response = await http.put(
      url + "api/Account",
      body: json.encode(data),
      headers: await AuthService.addAuthTokenToRequest(),
    );
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          isLoading = false;
        });
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (BuildContext context) => UserInfo()),
        //     (Route<dynamic> route) => false);
      }
    } else {
      setState(() {
        isLoading = false;
      });
      print(response.body);
    }
  }
}
