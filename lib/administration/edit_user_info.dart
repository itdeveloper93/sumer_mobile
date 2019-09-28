import 'package:flutter/material.dart';

import '../dashboard/global_drawer.dart';
import '../dashboard/global_appBar.dart';
import '../global.dart';

class EditUserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: GlobalDrawer(),
      appBar: GlobalAppBar(
        title: Container(
          transform: Matrix4.translationValues(-20, 1, 0),
          child: Text(
            'Edit User Info',
            style: TextStyle(
                color: Color(0xFF293148),
                fontFamily: "Roboto",
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Center(
        child: Text('Here is my edit user info'),
      ),
    );
  }
}
