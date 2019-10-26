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

class ActiveEmployeesList extends StatefulWidget {
  final bool onlyUsers;
  ActiveEmployeesList(this.onlyUsers);
  @override
  _ActiveEmployeesListState createState() =>
      _ActiveEmployeesListState(this.onlyUsers);
}

class _ActiveEmployeesListState extends State<ActiveEmployeesList> {
  List<ActiveEmployees> _employees = [];
  List<DepartmentsSelectList> _departments = [];

  _ActiveEmployeesListState(this.switchOn);

  bool isLoading;
  bool switchOn = false;

  void _onSwitchChanged(bool value) {
    setState(() {
      switchOn = value;
    });
  }

  @override
  void initState() {
    _loadActiveEmployees();
    this._loadDepartmentsSelectList();
    super.initState();
  }

  Future<void> _loadActiveEmployees() async {
    isLoading = false;
    http.Response response = await http.get(
      url +
          'api/Employees?fullName=${fullNameController.text}&departmentId=${currentSelectedValue.toString()}&onlyUsers=${switchOn.toString()}',
      // Send authorization headers to the backend.
      headers: await AuthService.addAuthTokenToRequest(),
    );
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      setState(() {
        _employees = ActiveEmployees.allFromResponse(response.body);
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
              _loadActiveEmployees();
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
              _loadActiveEmployees();

              // Navigator.pop(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => ActiveEmployeesList(null)));
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
                items: _departments.map((item) {
                  return DropdownMenuItem(
                    child: Text(item.name),
                    value: item.id.toString(),
                  );
                }).toList(),
                hint: Text("Отдел"),
                value: currentSelectedValue,
                isDense: true,
                onChanged: (value) {
                  setState(() {
                    print(value);
                    currentSelectedValue = value;
                  });
                },
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
          // Container(
          //   margin: EdgeInsets.only(bottom: 10),
          //   child: LabeledSwitch(
          //     label: 'Только пользователи',
          //     labelSize: 15,
          //     activeColor: Colors.blueAccent,
          //     value: switchOn,
          //     onChanged: (bool newValue) {
          //       setState(() {
          //         switchOn = newValue;
          //       });
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildEmployeesListTile(BuildContext context, int index) {
    var employee = _employees[index];

    return Container(
      padding: EdgeInsets.only(),
      child: Column(
        children: <Widget>[
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => Employee(employee.id),
                ),
              );
            },
            trailing: Icon(Icons.navigate_next),
            leading: Hero(
              tag: index,
              child: Container(
                width: 60,
                height: 60,
                child: ClipOval(
                  child: FadeInImage.assetNetwork(
                    fit: BoxFit.cover,
                    placeholder: 'assets/noavatar.jpg',
                    image: employee.photoPathSmall.toString(),
                  ),
                ),
              ),
            ),
            title: Text(employee.fullName),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 3),
                  child: Text(employee.department + ' › ' + employee.position),
                ),
                Container(
                  child: Text(employee.phone),
                )
              ],
            ),
          ),
          Divider(),
        ],
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
    } else if (_employees.length == null) {
      content = Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.blueAccent,
        ),
      );
    } else {
      content = ListView.builder(
        itemCount: _employees.length,
        itemBuilder: _buildEmployeesListTile,
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: GlobalDrawer(),
      appBar: GlobalAppBar(
        title: Container(
          transform: Matrix4.translationValues(-20, 1, 0),
          child: Text(
            'Активные сотрудники',
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
      }
    } else {
      setState(() {
        isLoading = false;
      });
      print(response.body);
    }
  }
}
