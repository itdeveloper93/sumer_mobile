import 'dart:convert';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:SAMR/services/auth_service.dart';

import 'package:SAMR/dashboard/global_appBar.dart';
import 'package:SAMR/dashboard/global_drawer.dart';
import 'package:SAMR/global.dart';

class SendMessageDetail extends StatefulWidget {
  final String id;
  SendMessageDetail(this.id);
  @override
  _SendMessageDetailState createState() => _SendMessageDetailState(id);
}

class _SendMessageDetailState extends State<SendMessageDetail>
    with SingleTickerProviderStateMixin {
  String id;
  _SendMessageDetailState(this.id);
  bool isLoading = false;

  String photoPath;
  String title;
  String body;
  String createdAt;
  String fullName;
  String position;
  Future<String> _loadSendMessage(String id) async {
    final response = await http.get(
      url + "api/Messages/Sent/" + id,
      // Send authorization headers to the backend.
      headers: await AuthService.addAuthTokenToRequest(),
    );
    setState(() {
      var extractdata = json.decode(response.body);
      photoPath = extractdata["data"]['user']['photoPath'];
      fullName = extractdata["data"]['user']['fullName'];
      position = extractdata["data"]['user']['positionName'];
      title = extractdata["data"]['title'];
      body = extractdata["data"]['body'];
      createdAt = extractdata["data"]['createdAt'];
    });
    return 'success';
  }

  @override
  void initState() {
    _loadSendMessage(id);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: GlobalDrawer(),
      appBar: GlobalAppBar(
        title: Container(
          transform: Matrix4.translationValues(-20, 1, 0),
          child: Text(
            'Send Detail',
            style: TextStyle(
                color: Color(0xFF293148),
                fontFamily: "Roboto",
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Container(
                width: 50,
                height: 50,
                child: ClipOval(
                  child: FadeInImage.assetNetwork(
                    fit: BoxFit.cover,
                    placeholder: 'assets/noavatar.jpg',
                    image: photoPath.toString(),
                  ),
                ),
              ),
              trailing: Container(
                transform: Matrix4.translationValues(0, -10, 0),
                child: Text(
                  createdAt.toString(),
                ),
              ),
              title: Text(fullName.toString()),
              subtitle: Text(
                position.toString(),
                style: TextStyle(
                  color: Color(0xff9da1ac),
                  fontSize: 13,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              child: Text(title.toString()),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Html(
                data: body.toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
