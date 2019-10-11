import 'package:flutter/material.dart';

class First extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
        child: new Center(
            child: new Icon(Icons.accessibility_new,
                size: 150.0, color: Colors.brown)));
  }
}

class Second extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
        child: new Center(
            child: new Icon(Icons.phone_android,
                size: 150.0, color: Colors.brown)));
  }
}
