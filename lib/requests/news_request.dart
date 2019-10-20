import 'dart:convert';
import 'package:SAMR/global.dart';
import 'package:SAMR/model/news_list_model.dart';
import 'package:SAMR/services/auth_service.dart';
import 'package:http/http.dart' as http;

class NewsRequest implements NewsRepository {
  Future<NewsPages> loadNews(int currentPage) async {
    http.Response response = await http.get(
      url + 'api/News?page=${currentPage.toString()}&pageSize=10',
      // Send authorization headers to the backend.
      headers: await AuthService.addAuthTokenToRequest(),
    );
    if (response.statusCode == 200) {
      return NewsPages.fromJson(json.decode(response.body));
    } else {
      throw Exception('Faild to load');
    }
  }
}

abstract class NewsRepository {
  Future<NewsPages> loadNews(int pageNumber);
}
