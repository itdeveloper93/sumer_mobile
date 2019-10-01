import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    return token;
  }

  static addAuthTokenToRequest() async {
    Map<String, String> headers = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: "application/json", // or whatever
      HttpHeaders.authorizationHeader: "Bearer " + await getToken(),
    };
    return headers;
  }
}
