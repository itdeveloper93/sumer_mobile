import 'dart:convert';

import 'package:SAMR/model/news_model.dart';

class NewsPages {
  List<NewsData> results;
  int page;
  int totalPages;
  int totalCount;
  int pageSize;

  NewsPages({
    this.results,
    this.page,
    this.totalPages,
    this.pageSize,
    this.totalCount,
  });

  factory NewsPages.fromRawJson(String str) =>
      NewsPages.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NewsPages.fromJson(Map<String, dynamic> json) => new NewsPages(
        results: List<NewsData>.from(
            json['data']['items'].map((x) => NewsData.fromMap(x))),
        page: json['data']["page"],
        totalPages: json['data']["totalPages"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(results.map((x) => x.toJson())),
        "page": page,
        "totalPages": totalPages,
      };
}
