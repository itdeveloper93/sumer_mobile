import 'package:flutter/material.dart';
// import 'package:SAMR/administration/user_info.dart';
import 'package:SAMR/dashboard/desktop/home.dart';
// import 'package:flutter/rendering.dart';

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
