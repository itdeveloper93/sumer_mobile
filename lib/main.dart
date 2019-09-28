import 'package:flutter/material.dart';
// import 'package:sumer_mobile/administration/user_info.dart';
import 'package:sumer_mobile/dashboard/home.dart';
// import 'package:sumer_mobile/authorization/login.dart';
// import 'package:sumer_mobile/dashboard/home.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// import 'package:sumer_mobile/dashboard/home.dart';

void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;

  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sumer",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(accentColor: Colors.white70),
      home: HomePage(),
    );
  }
}
