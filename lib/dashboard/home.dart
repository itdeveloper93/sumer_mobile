import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sumer_mobile/authorization/login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences sharedPreferences;
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
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
        // title: Image.asset(
        //   'assets/company-logo.png',
        //   height: 30,
        // ),
        actions: <Widget>[
          // FlatButton(
          //   onPressed: () {
          //     sharedPreferences.clear();
          //     sharedPreferences.commit();
          //     Navigator.of(context).pushAndRemoveUntil(
          //         MaterialPageRoute(
          //             builder: (BuildContext context) => LoginPage()),
          //         (Route<dynamic> route) => false);
          //   },
          //   child: Text("Log Out", style: TextStyle(color: Colors.black)),
          // ),
          Padding(
            padding: EdgeInsets.all(11),
            child: Image.asset(
              'assets/company-logo.png',
            ),
          )
        ],
      ),
      body: Center(child: Text("Dashboard")),
      drawer: Drawer(),
    );
  }
}
