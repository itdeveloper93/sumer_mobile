import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:SAMR/dashboard/desktop/home.dart';
import 'package:SAMR/global.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  String token;
  final _formKey = GlobalKey<FormState>();
  bool _validate = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
  }

  _validatePhone(var value) {
    if (phoneController.toString().isEmpty) {
      switch (value) {
        case '':
          return _showSnackBar('Номер телефона и пароль обязательно');
          break;
      }
    }
  }

  _validatePassword(var value) {
    if (phoneController.toString().isNotEmpty) {
      switch (value) {
        case '':
          return _showSnackBar('Номер телефона и пароль обязательно');
          break;
      }
    }
  }

  void _submit() {
    setState(() {
      _saving = true;
    });

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _saving = false;
      });
    });
  }

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
      resizeToAvoidBottomPadding: false,
      body: ModalProgressHUD(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Form(
              key: _formKey,
              autovalidate: _validate,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/bg.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 43,
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
          ),
          inAsyncCall: _saving),
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
        .post(url + "api/Auth/Login", body: json.encode(data), headers: {
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
        if (phoneNumber.isNotEmpty && password.toString().isNotEmpty) {
          _showSnackBar('Неверный логин или пароль.');
        }
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
        onPressed:
            // phoneController.text.isEmpty || passwordController.text.isEmpty
            //     ? null
            //     :
            () {
          if (_formKey.currentState.validate()) {
            _submit();
            setState(() {
              _isLoading = true;
            });
            signIn(phoneController.text, passwordController.text);
          }
        },
        elevation: 0.0,
        disabledColor: Colors.indigoAccent[700],
        color: Colors.indigoAccent[700],
        child: Text("Войти", style: TextStyle(color: Colors.white)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  Container textSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: TextFormField(
              maxLength: 9,
              keyboardType: TextInputType.number,
              controller: phoneController,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.local_phone),
                border: OutlineInputBorder(),
                labelText: 'Phone',
              ),
              validator: (value) {
                if (value.length < 8) {
                  return '9 character required!';
                }
                _validatePhone(value);
                return null;
              },
            ),
          ),
          Container(
            transform: Matrix4.translationValues(0, -15, 0),
            margin: EdgeInsets.only(bottom: 20),
            child: TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                suffixIcon: Icon(Icons.lock),
              ),
              validator: (value) {
                _validatePassword(value);
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Container headerSection() {
    return Container(
      margin: EdgeInsets.only(bottom: 35.0),
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
