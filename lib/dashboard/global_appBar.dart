import 'package:flutter/material.dart';

class GlobalAppBar extends AppBar {
  GlobalAppBar({Key key, Widget title})
      : super(
          key: key, title: title, elevation: 0.4,
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.apps, color: Colors.blueAccent[700]),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          // leading: IconButton(
          //   icon: Icon(Icons.apps,
          //       color: Colors.blueAccent[700]), // set your color here
          //   onPressed: () {
          //     _scaffoldKey.currentState.openDrawer();
          //   },
          // ),
          backgroundColor: Color(0xFFFFFFFF),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 6),
              child: Padding(
                padding: EdgeInsets.all(11),
                child: Image.asset(
                  'assets/company-logo.png',
                ),
              ),
            )
          ],
        );
}
