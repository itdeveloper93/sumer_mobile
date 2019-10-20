import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:SAMR/administration/user_info.dart';
import 'package:SAMR/model/profile_model.dart';
import 'package:SAMR/services/auth_service.dart';

import '../dashboard/global_drawer.dart';
import '../dashboard/global_appBar.dart';
import '../global.dart';

class EditUserInfo extends StatefulWidget {
  final Future<Profile> _myProfile;
  final String email;
  final String factualAddress;
  EditUserInfo(this._myProfile, this.email, this.factualAddress);
  @override
  _EditUserInfoState createState() =>
      _EditUserInfoState(_myProfile, email, factualAddress);
}

class _EditUserInfoState extends State<EditUserInfo> {
  String email;
  String factualAddress;
  Future<Profile> _myProfile;
  _EditUserInfoState(this._myProfile, this.email, this.factualAddress);

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    emailController.text = email;
    factualAddressController.text = factualAddress;
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
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => UserInfo()),
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
        'Редактирование данных',
        style: TextStyle(fontSize: 25),
      ),
    );
  }

  Container buttonSection() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width * 0.9,
      child: RaisedButton(
        onPressed: () {
          setState(() {
            isLoading = true;
          });
          submit(emailController.text, factualAddressController.text);
        },
        elevation: 0.0,
        color: Colors.indigoAccent[700],
        child: Text("Сохранить", style: TextStyle(color: Colors.white)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController factualAddressController =
      TextEditingController();

  Container textSection() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: TextFormField(
              controller: this.emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: TextFormField(
              controller: this.factualAddressController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Фактический адрес',
              ),
            ),
          ),
        ],
      ),
    );
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
        child: FutureBuilder<Profile>(
          future: _myProfile,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: <Widget>[
                  Container(
                    child: Card(
                      margin: EdgeInsets.only(),
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
                              snapshot.data.departmentName +
                                  ' › ' +
                                  snapshot.data.positionName,
                              style: TextStyle(
                                color: Color(0xFF858CA2),
                                fontFamily: "Roboto",
                                fontSize: 14,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10,
                      left: 10,
                      right: 10,
                    ),
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
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
                  )
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
