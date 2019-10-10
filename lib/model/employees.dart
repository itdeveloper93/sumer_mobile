import 'dart:convert';

class ActiveEmployees {
  ActiveEmployees(
      {this.id,
      this.fullName,
      this.photoPath,
      this.photoPathSmall,
      this.department,
      this.position,
      this.userId,
      this.phone,
      this.email});

  final String id;
  final String fullName;
  final String photoPath;
  final String photoPathSmall;
  final String department;
  final String position;
  final String userId;
  final String phone;
  final String email;

  static List<ActiveEmployees> allFromResponse(String response) {
    var decodedJson = json.decode(response).cast<String, dynamic>();

    return decodedJson['data']['items']
        .cast<Map<String, dynamic>>()
        .map((obj) => ActiveEmployees.fromMap(obj))
        .toList()
        .cast<ActiveEmployees>();
  }

  static ActiveEmployees fromMap(Map map) {
    return new ActiveEmployees(
      id: map['id'],
      fullName: map['fullName'],
      photoPath: map['photoPath'],
      photoPathSmall: map['photoPathSmall'],
      department: map['department'],
      position: map['position'],
      userId: map['userId'],
      phone: map['phone'],
      email: map['email'],
    );
  }

  static String _capitalize(String input) {
    return input.substring(0, 1).toUpperCase() + input.substring(1);
  }
}

class LockedEmployees {
  LockedEmployees(
      {this.id,
      this.fullName,
      this.department,
      this.position,
      this.userId,
      this.hireDate,
      this.lockDate,
      this.lockReason});

  final String id;
  final String fullName;
  final String department;
  final String position;
  final String userId;
  final String hireDate;
  final String lockDate;
  final String lockReason;

  static List<LockedEmployees> allFromResponse(String response) {
    var decodedJson = json.decode(response).cast<String, dynamic>();

    return decodedJson['data']['items']
        .cast<Map<String, dynamic>>()
        .map((obj) => LockedEmployees.fromMap(obj))
        .toList()
        .cast<LockedEmployees>();
  }

  static LockedEmployees fromMap(Map map) {
    return new LockedEmployees(
      id: map['id'],
      fullName: map['fullName'],
      department: map['department'],
      position: map['position'],
      userId: map['userId'],
      hireDate: map['hireDate'],
      lockDate: map['lockDate'],
      lockReason: map['lockReason'],
    );
  }

  static String _capitalize(String input) {
    return input.substring(0, 1).toUpperCase() + input.substring(1);
  }
}
