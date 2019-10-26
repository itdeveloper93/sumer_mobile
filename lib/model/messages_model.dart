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

class SendPages {
  List<SendModel> results;
  int page;
  int totalPages;
  int totalCount;
  int pageSize;

  SendPages({
    this.results,
    this.page,
    this.totalPages,
    this.pageSize,
    this.totalCount,
  });

  factory SendPages.fromRawJson(String str) =>
      SendPages.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SendPages.fromJson(Map<String, dynamic> json) => new SendPages(
        results: List<SendModel>.from(
            json['data']['items'].map((x) => SendModel.fromMap(x))),
        page: json['data']["page"],
        totalPages: json['data']["totalPages"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(results.map((x) => x.toJson())),
        "page": page,
        "totalPages": totalPages,
      };
}

class SendModel {
  SendModel({
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

  static List<SendModel> allFromResponse(String response) {
    var decodedJson = json.decode(response).cast<String, dynamic>();

    return decodedJson['data']['items']
        .cast<Map<String, dynamic>>()
        .map((obj) => SendModel.fromMap(obj))
        .toList()
        .cast<SendModel>();
  }

  static SendModel fromMap(Map map) {
    return new SendModel(
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
