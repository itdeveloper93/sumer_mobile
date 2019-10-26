import 'dart:convert';
import 'package:SAMR/messages/send.dart';
import 'package:SAMR/model/users.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:SAMR/services/auth_service.dart';

import '../dashboard/global_drawer.dart';
import '../dashboard/global_appBar.dart';
import '../global.dart';

class Compose extends StatefulWidget {
  @override
  _ComposeState createState() => _ComposeState();
}

class _ComposeState extends State<Compose> {
  bool isLoading = false;
  final _key = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  List<User> _users = [];

  @override
  void initState() {
    _loadUsersSelectList();
    super.initState();
  }

  Future<void> _loadUsersSelectList() async {
    http.Response response = await http.get(
      url + 'api/Account/UsersSelectListItems',
      // Send authorization headers to the backend.
      headers: await AuthService.addAuthTokenToRequest(),
    );

    setState(() {
      _users = User.allFromResponse(response.body);
    });
  }

  submit(String title, receiverUserId, body) async {
    Map data = {
      'title': title,
      'receiverUserId': receiverUserId,
      'body': body,
    };
    var jsonResponse;
    var response = await http.post(
      url + "api/Messages",
      body: json.encode(data),
      headers: await AuthService.addAuthTokenToRequest(),
    );
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => Send()),
            (Route<dynamic> route) => false);
      }
    } else {
      setState(() {
        isLoading = false;
      });
      print(response.body);
    }
  }

  Container headerSection() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      // padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        'Отправить сообщение',
        style: TextStyle(fontSize: 22),
      ),
    );
  }

  var currentSelectedValue;

  Widget _buildUsersDropdown() {
    return Container(
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0))),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                items: _users.map((item) {
                  return DropdownMenuItem(
                    child: Text(item.name),
                    value: item.id.toString(),
                  );
                }).toList(),
                hint: Text("Получатель"),
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

  Row buttonSection() {
    return Row(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.439,
          child: RaisedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                setState(() {
                  isLoading = true;
                });
                submit(titleController.text, currentSelectedValue,
                    bodyController.text);
                Navigator.pop(context);
              }
            },
            elevation: 0.0,
            color: Colors.indigoAccent[700],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 18,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("Написать", style: TextStyle(color: Colors.white)),
              ],
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.439,
          child: ButtonTheme(
            child: RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              elevation: 0.0,
              color: Color(0xFFecf0f5),
              child:
                  Text("Сбросить", style: TextStyle(color: Color(0xFF888fa3))),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          ),
        ),
      ],
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  _showSnackBar(String value) {
    final snackBar = new SnackBar(
      content: new Text(value),
      duration: new Duration(seconds: 3),
    );
    //How to display Snackbar ?
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  _validateFields(var value) {
    if (titleController.toString().isNotEmpty) {
      switch (value) {
        case '':
          return _showSnackBar('Заголовок и получатель обязательно');
          break;
      }
    }
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController receiverUserIdController =
      TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  Container textSection() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: TextFormField(
              controller: this.titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Заголовок',
              ),
              validator: (value) {
                return null;
              },
            ),
          ),
          _buildUsersDropdown(),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: TextFormField(
              maxLines: 2,
              keyboardType: TextInputType.multiline,
              controller: this.bodyController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              validator: (value) {
                _validateFields(value);
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: GlobalDrawer(),
      appBar: GlobalAppBar(
        title: Container(
          transform: Matrix4.translationValues(-20, 1, 0),
          child: Text(
            'Compose',
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
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                headerSection(),
                textSection(),
                buttonSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
