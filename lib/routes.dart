import 'package:sumer_mobile/dashboard/home.dart';

import './authorization/login.dart';
import 'administration/user_info.dart';

final routes = {
  '/login': (context) => LoginPage(),
  '/user-info': (context) => UserInfo(),
  'home': (context) => HomePage()
};
