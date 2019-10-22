import 'dart:convert';
import 'package:SAMR/global.dart';
import 'package:SAMR/services/auth_service.dart';
import 'package:http/http.dart' as http;

class EmployeesRequest implements EmployeesRepository {
  Future<int> loadEmployees() async {
    var _employee;
    final response = await http.get(
      url + "api/Employees",
      // Send authorization headers to the backend.
      headers: await AuthService.addAuthTokenToRequest(),
    );

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      Map decoded = json.decode(response.body);
      return _employee = decoded['data']['totalCount'];
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}

abstract class EmployeesRepository {
  Future<int> loadEmployees();
}
