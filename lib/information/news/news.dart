import 'package:SAMR/dashboard/global_appBar.dart';
import 'package:SAMR/dashboard/global_drawer.dart';
import 'package:SAMR/information/news/news_detail.dart';
import 'package:SAMR/model/news_list_model.dart';
import 'package:SAMR/requests/news_request.dart';
import 'package:flutter/material.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f7f8),
      drawer: GlobalDrawer(),
      appBar: GlobalAppBar(
        title: Container(
          transform: Matrix4.translationValues(-20, 1, 0),
          child: Text(
            'Новости',
            style: TextStyle(
                color: Color(0xFF293148),
                fontFamily: "Roboto",
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: FutureBuilder(
          future: NewsRequest().loadNews(1),
          builder: (BuildContext c, AsyncSnapshot snapshots) {
            if (snapshots.hasError) return Text("Error Occurred");
            switch (snapshots.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.none:
                return Center(child: Text('No data exist!'));
              case ConnectionState.done:
                return NewsList(
                  newsData: snapshots.data,
                );
              default:
                return Container();
            }
          }),
    );
  }
}

class NewsList extends StatefulWidget {
  final NewsPages newsData;
  const NewsList({
    this.newsData,
    Key key,
  }) : super(key: key);

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  ScrollController scrollController = new ScrollController();
  List<NewsData> news;
  int currentPage = 1;

  @override
  void initState() {
    news = widget.newsData.results;
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        NewsRequest().loadNews(currentPage + 1).then((val) {
          currentPage = val.page;
          setState(() {
            news.addAll(val.results);
          });
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: news.length,
      controller: scrollController,
      itemBuilder: (BuildContext c, int i) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => NewsDetail(news[i].id),
              ),
            );
          },
          child: Card(
            margin: EdgeInsets.only(bottom: 15),
            elevation: 0.3,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Container(
                    child: news[i].imagePath.isNotEmpty
                        ? Container(
                            child: Image.network(
                              news[i].photoPath,
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
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Text(
                            news[i].title != null ? news[i].title : '',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: news[i].isActive
                            ? Container(
                                width: 11,
                                child: Image.asset('assets/green-icon.png'),
                              )
                            : Container(
                                width: 16,
                                child: Image.asset('assets/red-icon.png'),
                              ),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16, top: 1, bottom: 10),
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
                          news[i].newsCategoryName != null
                              ? news[i].newsCategoryName
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
                          news[i].publishAt != null ? news[i].publishAt : '',
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
                      news[i].shortDescription.isNotEmpty
                          ? news[i].shortDescription
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
                            image: news[i].photoPath,
                          ),
                        ),
                      ),
                      title: Container(
                        transform: Matrix4.translationValues(-5, 0, 0),
                        child: Text(
                          news[i].fullName.isNotEmpty
                              ? news[i].fullName
                              : 'Full Name',
                          style: TextStyle(
                            color: Color(0xffa9b3d3),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      subtitle: Container(
                        transform: Matrix4.translationValues(-5, 0, 0),
                        child: Text(
                          news[i].positionName != null
                              ? news[i].positionName
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
        );
      },
    );
  }
}
