import 'dart:convert';
import 'package:SAMR/global.dart';
import 'package:SAMR/model/files_list_model.dart';
import 'package:SAMR/services/auth_service.dart';
import 'package:http/http.dart' as http;

class FilesRequest implements FilesRepository {
  Future<FilesPages> loadFiles(int currentPage) async {
    http.Response response = await http.get(
      url + 'api/Files?page=${currentPage.toString()}&pageSize=10',
      // Send authorization headers to the backend.
      headers: await AuthService.addAuthTokenToRequest(),
    );
    if (response.statusCode == 200) {
      return FilesPages.fromJson(json.decode(response.body));
    } else {
      throw Exception('Faild to load');
    }
  }
}

abstract class FilesRepository {
  Future<FilesPages> loadFiles(int pageNumber);
}
