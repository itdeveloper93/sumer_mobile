import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sumer_mobile/administration/employees/active_employees_list.dart';
import 'package:sumer_mobile/administration/employees/locked_employees_list.dart';
import 'package:sumer_mobile/services/auth_service.dart';
import '../administration/user_info.dart';
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
    return MiniProfile.fromJson(
      parseJwt(
        await AuthService.getToken(),
      ),
    );
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
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserInfo(),
                      ),
                    );
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
                          currentAccountPicture: Container(
                            width: 120,
                            height: 120,
                            child: ClipOval(
                              child: FadeInImage.assetNetwork(
                                fit: BoxFit.cover,
                                placeholder: 'assets/noavatar.jpg',
                                image: snapshot.data.photo,
                              ),
                            ),
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
                ExpansionTile(
                  leading: Icon(
                    Icons.library_books,
                    color: Color(0xFFd2d7e8),
                  ),
                  title: Text(
                    'Новости и информация',
                    style: TextStyle(
                      color: Color(0xFFd2d7e8),
                    ),
                  ),
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 56),
                      child: ListTile(
                        title: Text(
                          'Новости',
                          style: TextStyle(
                            color: Color(0xFF767d92),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 56),
                      child: ListTile(
                        title: Text(
                          'Полезные ссылки',
                          style: TextStyle(
                            color: Color(0xFF767d92),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 56),
                      child: ListTile(
                        title: Text(
                          'Файловый архив',
                          style: TextStyle(
                            color: Color(0xFF767d92),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  leading: Icon(
                    Icons.settings_input_component,
                    color: Color(0xFFd2d7e8),
                  ),
                  title: Text(
                    'Администрирование',
                    style: TextStyle(
                      color: Color(0xFFd2d7e8),
                    ),
                  ),
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 56),
                      child: ExpansionTile(
                        title: Text(
                          'Сотрудники',
                          style: TextStyle(
                            color: Color(0xFF767d92),
                            fontSize: 13,
                          ),
                        ),
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 25),
                            child: ListTile(
                              title: Text(
                                'Активные',
                                style: TextStyle(
                                  color: Color(0xFF767d92),
                                  fontSize: 13,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ActiveEmployeesList(),
                                    ));
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 25),
                            child: ListTile(
                              title: Text(
                                'Заблокированные',
                                style: TextStyle(
                                  color: Color(0xFF767d92),
                                  fontSize: 13,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          LockedEmployeesList(),
                                    ));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
                  AuthService.logout(context);
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
