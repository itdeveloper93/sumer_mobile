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
  String token;
  var _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  _showSnackBar(String value) {
    final snackBar = new SnackBar(
      content: new Text(value),
      duration: new Duration(seconds: 3),
    );
    //How to display Snackbar ?
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Form(
          key: _formKey,
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
                      bottom: 183,
                      left: 20,
                    ),
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 42,
                          right: 35,
                          left: 35,
                        ),
                        child: Column(
                          children: <Widget>[
                            headerSection(),
                            textSection(),
                            buttonSection(),
                          ],
                        ),
                      ),
                    ),
                  ),
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
        .post(URL + "api/Auth/Login", body: json.encode(data), headers: {
      "content-type": "application/json",
      "accept": "application/json",
    });
    switch (response.statusCode) {
      case 200:
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
        break;
      case 400:
        _showSnackBar('Неверный логин или пароль.');
        setState(() {
          _isLoading = false;
        });
        break;
    }
  }

  getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("token");
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 55.0,
      child: RaisedButton(
        onPressed: () {
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
              keyboardType: TextInputType.number,
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
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Must not be empty!';
                }
              },
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
