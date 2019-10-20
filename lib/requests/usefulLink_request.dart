import 'dart:convert';
import 'package:SAMR/global.dart';
import 'package:SAMR/model/usefulLink_list_model.dart';
import 'package:SAMR/services/auth_service.dart';
import 'package:http/http.dart' as http;

class UsefulLinkRequest implements UsefulLinkRepository {
  Future<UsefulLinkPages> loadUsefulLink(int currentPage) async {
    http.Response response = await http.get(
      url + 'api/UsefulLinks?page=${currentPage.toString()}&pageSize=10',
      // Send authorization headers to the backend.
      headers: await AuthService.addAuthTokenToRequest(),
    );
    if (response.statusCode == 200) {
      return UsefulLinkPages.fromJson(json.decode(response.body));
    } else {
      throw Exception('Faild to load');
    }
  }
}

abstract class UsefulLinkRepository {
  Future<UsefulLinkPages> loadUsefulLink(int pageNumber);
}
