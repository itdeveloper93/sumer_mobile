import 'package:flutter/material.dart';

import './global_drawer.dart';
import './global_appBar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: GlobalDrawer(),
      appBar: GlobalAppBar(
        title: Container(
          transform: Matrix4.translationValues(-20, 1, 0),
          child: Text(
            'Home Page',
            style: TextStyle(
                color: Color(0xFF293148),
                fontFamily: "Roboto",
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Center(
        child: Text('Here is my Home Page!'),
      ),
    );
  }
}
