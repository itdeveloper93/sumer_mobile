import 'dart:convert';

class InboxPages {
  List<InboxModel> results;
  int page;
  int totalPages;
  int totalCount;
  int pageSize;

  InboxPages({
    this.results,
    this.page,
    this.totalPages,
    this.pageSize,
    this.totalCount,
  });

  factory InboxPages.fromRawJson(String str) =>
      InboxPages.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InboxPages.fromJson(Map<String, dynamic> json) => new InboxPages(
        results: List<InboxModel>.from(
            json['data']['items'].map((x) => InboxModel.fromMap(x))),
        page: json['data']["page"],
        totalPages: json['data']["totalPages"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(results.map((x) => x.toJson())),
        "page": page,
        "totalPages": totalPages,
      };
}

class InboxModel {
  InboxModel({
    this.id,
    this.title,
    this.body,
    this.receiverUserId,
    this.senderUserId,
    this.readDate,
    this.createdAt,
    this.fullName,
    this.photoPath,
    this.employeeId,
    this.positionName,
  });

  final String id;
  final String title;
  final String body;
  final String receiverUserId;
  final String senderUserId;
  final String readDate;
  final String createdAt;
  final String fullName;
  final String photoPath;
  final String employeeId;
  final String positionName;

  static List<InboxModel> allFromResponse(String response) {
    var decodedJson = json.decode(response).cast<String, dynamic>();

    return decodedJson['data']['items']
        .cast<Map<String, dynamic>>()
        .map((obj) => InboxModel.fromMap(obj))
        .toList()
        .cast<InboxModel>();
  }

  static InboxModel fromMap(Map map) {
    return new InboxModel(
      id: map['id'],
      title: map['title'],
      body: map['body'],
      receiverUserId: map['receiverUserId'],
      readDate: map['readDate'],
      createdAt: map['createdAt'],
      fullName: map['user']['fullName'],
      photoPath: map['user']['photoPath'],
      employeeId: map['user']['employeeId'],
      positionName: map['user']['positionName'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "receiverUserId": receiverUserId,
        "title": title,
        "readDate": readDate,
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

class SentPages {
  List<SentModel> results;
  int page;
  int totalPages;
  int totalCount;
  int pageSize;

  SentPages({
    this.results,
    this.page,
    this.totalPages,
    this.pageSize,
    this.totalCount,
  });

  factory SentPages.fromRawJson(String str) =>
      SentPages.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SentPages.fromJson(Map<String, dynamic> json) => new SentPages(
        results: List<SentModel>.from(
            json['data']['items'].map((x) => SentModel.fromMap(x))),
        page: json['data']["page"],
        totalPages: json['data']["totalPages"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(results.map((x) => x.toJson())),
        "page": page,
        "totalPages": totalPages,
      };
}

class SentModel {
  SentModel({
    this.id,
    this.title,
    this.body,
    this.receiverUserId,
    this.senderUserId,
    this.readDate,
    this.createdAt,
    this.fullName,
    this.photoPath,
    this.employeeId,
    this.positionName,
  });

  final String id;
  final String title;
  final String body;
  final String receiverUserId;
  final String senderUserId;
  final String readDate;
  final String createdAt;
  final String fullName;
  final String photoPath;
  final String employeeId;
  final String positionName;

  static List<SentModel> allFromResponse(String response) {
    var decodedJson = json.decode(response).cast<String, dynamic>();

    return decodedJson['data']['items']
        .cast<Map<String, dynamic>>()
        .map((obj) => SentModel.fromMap(obj))
        .toList()
        .cast<SentModel>();
  }

  static SentModel fromMap(Map map) {
    return new SentModel(
      id: map['id'],
      title: map['title'],
      body: map['body'],
      receiverUserId: map['receiverUserId'],
      readDate: map['readDate'],
      createdAt: map['createdAt'],
      fullName: map['user']['fullName'],
      photoPath: map['user']['photoPath'],
      employeeId: map['user']['employeeId'],
      positionName: map['user']['positionName'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "receiverUserId": receiverUserId,
        "title": title,
        "readDate": readDate,
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
