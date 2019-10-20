import 'dart:convert';

class NewsData {
  NewsData({
    this.id,
    this.title,
    this.shortDescription,
    this.publishAt,
    this.newsCategoryName,
    this.imagePath,
    this.isActive,
    this.fullName,
    this.photoPath,
    this.employeeId,
    this.positionName,
  });

  final String id;
  final String title;
  final String shortDescription;
  final String publishAt;
  final String newsCategoryName;
  final String imagePath;
  final bool isActive;
  final String fullName;
  final String photoPath;
  final String employeeId;
  final String positionName;

  static List<NewsData> allFromResponse(String response) {
    var decodedJson = json.decode(response).cast<String, dynamic>();

    return decodedJson['data']['items']
        .cast<Map<String, dynamic>>()
        .map((obj) => NewsData.fromMap(obj))
        .toList()
        .cast<NewsData>();
  }

  static NewsData fromMap(Map map) {
    return new NewsData(
      id: map['id'],
      title: map['title'],
      shortDescription: map['shortDescription'],
      publishAt: map['publishAt'],
      newsCategoryName: map['newsCategoryName'],
      imagePath: map['imagePath'],
      isActive: map['isActive'],
      fullName: map['author']['fullName'],
      photoPath: map['author']['photoPath'],
      employeeId: map['author']['employeeId'],
      positionName: map['author']['positionName'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "shortDescription": shortDescription,
        "publishAt": publishAt,
        "newsCategoryName": newsCategoryName,
        "imagePath": imagePath,
        "isActive": isActive,
        "fullName": fullName,
        "photoPath": photoPath,
        "employeeId": employeeId,
        "positionName": positionName,
      };

  static String _capitalize(String input) {
    return input.substring(0, 1).toUpperCase() + input.substring(1);
  }
}
