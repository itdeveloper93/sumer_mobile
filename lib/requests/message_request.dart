import 'dart:convert';
import 'package:SAMR/global.dart';
import 'package:SAMR/model/messages_model.dart';
import 'package:SAMR/services/auth_service.dart';
import 'package:http/http.dart' as http;

class MessagesRequest implements MessagesRepository {
  Future<InboxPages> loadInbox(
      int currentPage, String title, String fromDate, String toDate) async {
    http.Response response = await http.get(
      url + 'api/Messages/Received?page=${currentPage.toString()}&pageSize=10&',
      // Send authorization headers to the backend.
      headers: await AuthService.addAuthTokenToRequest(),
    );
    if (response.statusCode == 200) {
      return InboxPages.fromJson(json.decode(response.body));
    } else {
      throw Exception('Faild to load');
    }
  }

  Future<SendPages> loadSend(
      int currentPage, String title, String fromDate, String toDate) async {
    http.Response response = await http.get(
      url + 'api/Messages/Sent?page=${currentPage.toString()}&pageSize=10&',
      // Send authorization headers to the backend.
      headers: await AuthService.addAuthTokenToRequest(),
    );
    if (response.statusCode == 200) {
      return SendPages.fromJson(json.decode(response.body));
    } else {
      throw Exception('Faild to load');
    }
  }
}

abstract class MessagesRepository {
  Future<InboxPages> loadInbox(
      int pageNumber, String title, String fromDate, String toDate);
  Future<SendPages> loadSend(
      int pageNumber, String title, String fromDate, String toDate);
}
