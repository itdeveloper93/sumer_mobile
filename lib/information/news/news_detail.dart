import 'dart:convert';
import 'package:SAMR/model/news_detail.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:SAMR/services/auth_service.dart';

import 'package:SAMR/dashboard/global_appBar.dart';
import 'package:SAMR/dashboard/global_drawer.dart';
import 'package:SAMR/global.dart';

class NewsDetail extends StatefulWidget {
  final String id;
  NewsDetail(this.id);
  @override
  _NewsDetailState createState() => _NewsDetailState(id);
}

class _NewsDetailState extends State<NewsDetail>
    with SingleTickerProviderStateMixin {
  Future<NewsDetailModel> _newsDetail;
  String id;
  _NewsDetailState(this.id);
  bool isLoading = false;

  Future<NewsDetailModel> _loadEmployee(String id) async {
    final response = await http.get(
      url + "api/News/" + id,
      // Send authorization headers to the backend.
      headers: await AuthService.addAuthTokenToRequest(),
    );

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      return NewsDetailModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  @override
  void initState() {
    _newsDetail = _loadEmployee(this.id);
    print(this.id);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f7f8),
      drawer: GlobalDrawer(),
      appBar: GlobalAppBar(
        title: Container(
          transform: Matrix4.translationValues(-20, 1, 0),
          child: Text(
            'News Detail',
            style: TextStyle(
                color: Color(0xFF293148),
                fontFamily: "Roboto",
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: FutureBuilder<NewsDetailModel>(
          future: _newsDetail,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: <Widget>[
                  Container(
                    child: Card(
                      margin: EdgeInsets.only(bottom: 15),
                      elevation: 0.3,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: snapshot.data.imagePath.isNotEmpty
                                  ? Container(
                                      child: Image.network(
                                        snapshot.data.photoPath,
                                        height: 300,
                                        width: 410,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Container(),
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 17,
                                    top: 25,
                                    bottom: 5,
                                  ),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Text(
                                      snapshot.data.title != null
                                          ? snapshot.data.title
                                          : '',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: snapshot.data.isActive
                                      ? Container(
                                          width: 11,
                                          child: Image.asset(
                                              'assets/green-icon.png'),
                                        )
                                      : Container(
                                          width: 16,
                                          child: Image.asset(
                                              'assets/red-icon.png'),
                                        ),
                                )
                              ],
                            ),
                            Container(
                              padding:
                                  EdgeInsets.only(left: 16, top: 1, bottom: 10),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Icon(
                                    Icons.folder,
                                    size: 16,
                                    color: Color(0xff9da1ac),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    snapshot.data.newsCategoryName != null
                                        ? snapshot.data.newsCategoryName
                                        : '',
                                    style: TextStyle(
                                      color: Color(0xff9da1ac),
                                      fontSize: 13,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.date_range,
                                    size: 16,
                                    color: Color(0xff9da1ac),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    snapshot.data.publishAt != null
                                        ? snapshot.data.publishAt
                                        : '',
                                    style: TextStyle(
                                      color: Color(0xff9da1ac),
                                      fontSize: 13,
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(right: 16))
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              margin: EdgeInsets.only(bottom: 10),
                              child: Text(
                                snapshot.data.description.isNotEmpty
                                    ? snapshot.data.description
                                    : '',
                                style: TextStyle(
                                  color: Color(0xff30384d),
                                  height: 1.4,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                bottom: 10,
                              ),
                              child: ListTile(
                                leading: Container(
                                  width: 40,
                                  height: 40,
                                  child: ClipOval(
                                    child: FadeInImage.assetNetwork(
                                      fit: BoxFit.cover,
                                      placeholder: 'assets/noavatar.jpg',
                                      image: snapshot.data.photoPath,
                                    ),
                                  ),
                                ),
                                title: Container(
                                  transform:
                                      Matrix4.translationValues(-5, 0, 0),
                                  child: Text(
                                    snapshot.data.fullName.isNotEmpty
                                        ? snapshot.data.fullName
                                        : 'Full Name',
                                    style: TextStyle(
                                      color: Color(0xffa9b3d3),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                subtitle: Container(
                                  transform:
                                      Matrix4.translationValues(-5, 0, 0),
                                  child: Text(
                                    snapshot.data.positionName != null
                                        ? snapshot.data.positionName
                                        : 'Position',
                                    style: TextStyle(
                                      color: Color(0xffa9b3d3),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blueAccent,
              ),
            );
          },
        ),
      ),
    );
  }
}
