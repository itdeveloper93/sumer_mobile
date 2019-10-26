import 'package:SAMR/information/news/news_detail.dart';
import 'package:SAMR/model/news_list_model.dart';
import 'package:flutter/material.dart';
import 'package:SAMR/global.dart';
import 'package:SAMR/services/auth_service.dart';
import 'package:http/http.dart' as http;

class LastNewsListTitle extends StatefulWidget {
  _LastNewsListTitleState createState() => _LastNewsListTitleState();
}

class _LastNewsListTitleState extends State<LastNewsListTitle>
    with AutomaticKeepAliveClientMixin<LastNewsListTitle> {
  List<LastNews> _lastNewsData = [];
  // Future<LastNews> _lastNewsData;
  @override
  void initState() {
    super.initState();
    _loadLastNewsData();
  }

  Future<void> _loadLastNewsData() async {
    http.Response response = await http.get(
      url + "api/News?pageSize=5",
      // Send authorization headers to the backend.
      headers: await AuthService.addAuthTokenToRequest(),
    );

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      setState(() {
        _lastNewsData = LastNews.allFromResponse(response.body);
      });
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _lastNewsData.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.only(
              top: 10,
              left: 13,
              right: 13,
            ),
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          NewsDetail(_lastNewsData[index].id.toString()),
                    ),
                  );
                },
                leading: Container(
                  width: 50,
                  height: 50,
                  child: ClipOval(
                    child: FadeInImage.assetNetwork(
                      fit: BoxFit.cover,
                      placeholder: 'assets/image-placeholder.png',
                      image: _lastNewsData[index].photoPath,
                    ),
                  ),
                ),
                title: Text(_lastNewsData[index].title),
                subtitle: Container(
                  child: Row(
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
                        _lastNewsData[index].newsCategoryName,
                        style: TextStyle(
                          color: Color(0xff9da1ac),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                trailing: Container(
                  transform: Matrix4.translationValues(0, 9, 0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(Icons.date_range, size: 16),
                        ),
                        TextSpan(
                          text: _lastNewsData[index].publishAt,
                          style: TextStyle(
                            color: Color(0xff9da1ac),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
