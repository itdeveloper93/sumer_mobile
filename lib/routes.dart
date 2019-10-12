import 'package:flutter/material.dart';
import 'package:sumer_mobile/dashboard/home.dart';

import './authorization/login.dart';
import 'administration/user_info.dart';

final routes = {
  '/login': (BuildContext context) => LoginPage(),
  '/user-info': (BuildContext context) => UserInfo(),
  'home': (context) => HomePage()
};
