import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sumer_mobile/dashboard/home.dart';

import '../global.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: EdgeInsets.only(
                    top: 190,
                    right: 20,
                    bottom: 180,
                    left: 20,
                  ),
                  child: Card(
                      child: Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                      right: 35,
                      bottom: 30,
                      left: 35,
                    ),
                    child: ListView(
                      children: <Widget>[
                        headerSection(),
                        textSection(),
                        buttonSection(),
                      ],
                    ),
                  )),
                ),
        ),
      ),
    );
  }

  signIn(String phoneNumber, password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'phoneNumber': phoneNumber,
      'password': password,
      'rememberMe': true
    };
    var jsonResponse;
    var response = await http
        .post(URL + "api/Account/Login", body: json.encode(data), headers: {
      "content-type": "application/json",
      "accept": "application/json",
    });
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("token", jsonResponse['data']['token']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => HomePage()),
            (Route<dynamic> route) => false);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 55.0,
      child: RaisedButton(
        onPressed: emailController.text == "" || passwordController.text == ""
            ? null
            : () {
                setState(() {
                  _isLoading = true;
                });
                signIn(emailController.text, passwordController.text);
              },
        elevation: 0.0,
        color: Colors.indigoAccent[700],
        child: Text("Войти", style: TextStyle(color: Colors.white)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  Container textSection() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.local_phone),
                border: OutlineInputBorder(),
                labelText: 'Phone',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                suffixIcon: Icon(Icons.lock),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container headerSection() {
    return Container(
      margin: EdgeInsets.only(bottom: 50.0),
      // padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            margin: EdgeInsets.only(bottom: 15),
            child: Image.asset('assets/company-logo.png'),
          ),
          Text(
            'Вход в систему',
            style: TextStyle(fontSize: 25),
          )
        ],
      ),
    );
  }
}
