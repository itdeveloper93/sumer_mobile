import 'package:flutter/material.dart';
import 'package:sumer_mobile/administration/edit_user_info.dart';
import 'package:sumer_mobile/dashboard/home.dart';

import './authorization/login.dart';
import 'administration/user_info.dart';

final routes = {
  '/login': (BuildContext context) => LoginPage(),
  '/user-info': (BuildContext context) => UserInfo(),
  '/edit-user-info': (BuildContext context) => EditUserInfo(),
  'home': (context) => HomePage()
};
