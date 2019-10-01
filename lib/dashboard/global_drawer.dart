import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sumer_mobile/services/auth_service.dart';
import '../administration/user_info.dart';
import '../authorization/login.dart';
import '../common/parse_token.dart';
import '../model/mini_profile.dart';

import './home.dart';

class GlobalDrawer extends StatefulWidget {
  @override
  _GlobalDrawerState createState() => _GlobalDrawerState();
}

class _GlobalDrawerState extends State<GlobalDrawer> {
  MiniProfile miniProfile;
  Future<MiniProfile> profileFuture;

  @override
  void initState() {
    super.initState();
    profileFuture = myProfile();
    // myMethod()
    //     .then((success) => checkLoginStatus())
    //     .catchError((e) => print(e))
    //     .whenComplete(() {});
  }

  Future<MiniProfile> myProfile() async {
    return MiniProfile.fromJson(parseJwt(
      await AuthService.getToken(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFF293147),
        child: Column(children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    // Navigator.of(context).pushAndRemoveUntil(
                    //     MaterialPageRoute(
                    //         builder: (BuildContext context) => LoginPage()),
                    //     (Route<dynamic> route) => false);
                  },
                  child: FutureBuilder<MiniProfile>(
                    future: profileFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return UserAccountsDrawerHeader(
                          accountName: Text(
                            snapshot.data.name,
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 16,
                            ),
                          ),
                          accountEmail: Text(
                            snapshot.data.position,
                            style: TextStyle(
                              color: Color(0xFFd2d7e8).withAlpha(200),
                              fontSize: 14,
                            ),
                          ),
                          currentAccountPicture: CircleAvatar(
                            backgroundImage: NetworkImage(snapshot.data.photo),
                            backgroundColor: Colors.transparent,
                          ),
                          decoration: BoxDecoration(
                              color: Color(0xFF323C58),
                              image: DecorationImage(
                                  image: AssetImage("assets/drawer-bg2.jpeg"),
                                  fit: BoxFit.cover)),
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }

                      // By default, show a loading spinner.
                      return CircularProgressIndicator();
                    },
                  ),
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
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ));
                  },
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
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserInfo(),
                        ));
                  },
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
    );
  }
}
