import 'dart:convert';

class UsefulLinkPages {
  List<UsefulLinkModel> results;
  int page;
  int totalPages;
  int totalCount;
  int pageSize;

  UsefulLinkPages({
    this.results,
    this.page,
    this.totalPages,
    this.pageSize,
    this.totalCount,
  });

  factory UsefulLinkPages.fromRawJson(String str) =>
      UsefulLinkPages.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UsefulLinkPages.fromJson(Map<String, dynamic> json) =>
      new UsefulLinkPages(
        results: List<UsefulLinkModel>.from(
            json['data']['items'].map((x) => UsefulLinkModel.fromMap(x))),
        page: json['data']["page"],
        totalPages: json['data']["totalPages"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(results.map((x) => x.toJson())),
        "page": page,
        "totalPages": totalPages,
      };
}

class UsefulLinkModel {
  UsefulLinkModel({
    this.id,
    this.usefulLinkCategoryId,
    this.usefulLinkCategoryName,
    this.url,
    this.title,
    this.description,
    this.isActive,
    this.createdAt,
    this.fullName,
    this.photoPath,
    this.employeeId,
    this.positionName,
  });

  final String id;
  final String usefulLinkCategoryId;
  final String usefulLinkCategoryName;
  final String url;
  final String title;
  final String description;
  final bool isActive;
  final String createdAt;
  final String fullName;
  final String photoPath;
  final String employeeId;
  final String positionName;

  static List<UsefulLinkModel> allFromResponse(String response) {
    var decodedJson = json.decode(response).cast<String, dynamic>();

    return decodedJson['data']['items']
        .cast<Map<String, dynamic>>()
        .map((obj) => UsefulLinkModel.fromMap(obj))
        .toList()
        .cast<UsefulLinkModel>();
  }

  static UsefulLinkModel fromMap(Map map) {
    return new UsefulLinkModel(
      id: map['id'],
      usefulLinkCategoryId: map['usefulLinkCategoryId'],
      usefulLinkCategoryName: map['usefulLinkCategoryName'],
      url: map['url'],
      title: map['title'],
      description: map['description'],
      isActive: map['isActive'],
      createdAt: map['createdAt'],
      fullName: map['author']['fullName'],
      photoPath: map['author']['photoPath'],
      employeeId: map['author']['employeeId'],
      positionName: map['author']['positionName'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "usefulLinkCategoryId": usefulLinkCategoryId,
        "usefulLinkCategoryName": usefulLinkCategoryName,
        "url": url,
        "title": title,
        "description": description,
        "isActive": isActive,
        "createdAt": createdAt,
        "fullName": fullName,
        "photoPath": photoPath,
        "employeeId": employeeId,
        "positionName": positionName,
      };

  static String _capitalize(String input) {
    return input.substring(0, 1).toUpperCase() + input.substring(1);
  }
}
