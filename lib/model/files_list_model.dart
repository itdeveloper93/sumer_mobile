import 'dart:convert';

class FilesPages {
  List<FilesModel> results;
  int page;
  int totalPages;
  int totalCount;
  int pageSize;

  FilesPages({
    this.results,
    this.page,
    this.totalPages,
    this.pageSize,
    this.totalCount,
  });

  factory FilesPages.fromRawJson(String str) =>
      FilesPages.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FilesPages.fromJson(Map<String, dynamic> json) => new FilesPages(
        results: List<FilesModel>.from(
            json['data']['items'].map((x) => FilesModel.fromMap(x))),
        page: json['data']["page"],
        totalPages: json['data']["totalPages"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(results.map((x) => x.toJson())),
        "page": page,
        "totalPages": totalPages,
      };
}

class FilesModel {
  FilesModel({
    this.id,
    this.title,
    this.description,
    this.isActive,
    this.filePath,
    this.createdAt,
    this.fileCategoryName,
    this.fullName,
    this.photoPath,
    this.employeeId,
    this.positionName,
  });

  final String id;
  final String title;
  final String description;
  final bool isActive;
  final String filePath;
  final String createdAt;
  final String fileCategoryName;
  final String fullName;
  final String photoPath;
  final String employeeId;
  final String positionName;

  static List<FilesModel> allFromResponse(String response) {
    var decodedJson = json.decode(response).cast<String, dynamic>();

    return decodedJson['data']['items']
        .cast<Map<String, dynamic>>()
        .map((obj) => FilesModel.fromMap(obj))
        .toList()
        .cast<FilesModel>();
  }

  static FilesModel fromMap(Map map) {
    return new FilesModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isActive: map['isActive'],
      filePath: map['filePath'],
      createdAt: map['createdAt'],
      fileCategoryName: map['fileCategoryName'],
      fullName: map['author']['fullName'],
      photoPath: map['author']['photoPath'],
      employeeId: map['author']['employeeId'],
      positionName: map['author']['positionName'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "isActive": isActive,
        "filePath": filePath,
        "createdAt": createdAt,
        "fileCategoryName": fileCategoryName,
        "fullName": fullName,
        "photoPath": photoPath,
        "employeeId": employeeId,
        "positionName": positionName,
      };

  static String _capitalize(String input) {
    return input.substring(0, 1).toUpperCase() + input.substring(1);
  }
}
