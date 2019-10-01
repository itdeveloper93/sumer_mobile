import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sumer_mobile/administration/edit_user_info.dart';
import 'package:sumer_mobile/model/profile_model.dart';
import 'package:sumer_mobile/services/auth_service.dart';
import 'dart:async';

import '../dashboard/global_drawer.dart';
import '../dashboard/global_appBar.dart';
import '../global.dart';

class UserInfo extends StatelessWidget {
  Future<Profile> fetchMyProfile() async {
    final response = await http.get(
      URL + "api/Account/MyInfo",
      // Send authorization headers to the backend.
      headers: await AuthService.addAuthTokenToRequest(),
    );

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      return Profile.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: GlobalDrawer(),
      appBar: GlobalAppBar(
        title: Container(
          transform: Matrix4.translationValues(-20, 1, 0),
          child: Text(
            'User Info',
            style: TextStyle(
                color: Color(0xFF293148),
                fontFamily: "Roboto",
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: FutureBuilder<Profile>(
        future: fetchMyProfile(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: <Widget>[
                Container(
                  child: Card(
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
                  padding: EdgeInsets.only(
                    top: 5,
                  ),
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.only(left: 25, bottom: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 20),
                            child: Text(
                              'Дата рождения',
                              style: TextStyle(
                                color: Color(0xFF293148),
                                fontFamily: "Roboto",
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              snapshot.data.dateOfBirth,
                              style: TextStyle(
                                color: Color(0xFF858CA2),
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.black26,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              'Отдель',
                              style: TextStyle(
                                color: Color(0xFF293148),
                                fontFamily: "Roboto",
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              snapshot.data.departmentName,
                              style: TextStyle(
                                color: Color(0xFF858CA2),
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.black26,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              'Позиция',
                              style: TextStyle(
                                color: Color(0xFF293148),
                                fontFamily: "Roboto",
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              snapshot.data.positionName,
                              style: TextStyle(
                                color: Color(0xFF858CA2),
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.black26,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              'Дата приема на работу',
                              style: TextStyle(
                                color: Color(0xFF293148),
                                fontFamily: "Roboto",
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              snapshot.data.hireDate,
                              style: TextStyle(
                                color: Color(0xFF858CA2),
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.black26,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              'Телефон',
                              style: TextStyle(
                                color: Color(0xFF293148),
                                fontFamily: "Roboto",
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              snapshot.data.phone,
                              style: TextStyle(
                                color: Color(0xFF858CA2),
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.black26,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              'Email',
                              style: TextStyle(
                                color: Color(0xFF293148),
                                fontFamily: "Roboto",
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              snapshot.data.email,
                              style: TextStyle(
                                color: Color(0xFF858CA2),
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.black26,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              'Фактический адрес',
                              style: TextStyle(
                                color: Color(0xFF293148),
                                fontFamily: "Roboto",
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              snapshot.data.factualAddress,
                              style: TextStyle(
                                color: Color(0xFF858CA2),
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.black26,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              'Пол',
                              style: TextStyle(
                                color: Color(0xFF293148),
                                fontFamily: "Roboto",
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              snapshot.data.genderName,
                              style: TextStyle(
                                color: Color(0xFF858CA2),
                              ),
                            ),
                          ),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (BuildContext context) => EditUserInfo(),
              ),
              (Route<dynamic> route) => false);
        },
      ),
    );
  }
}
