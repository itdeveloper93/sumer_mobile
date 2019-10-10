import 'dart:convert';

class DepartmentsSelectList {
  DepartmentsSelectList({
    this.id,
    this.name,
  });

  final String id;
  final String name;

  static List<DepartmentsSelectList> allFromResponse(String response) {
    var decodedJson = json.decode(response).cast<String, dynamic>();

    return decodedJson['data']
        .cast<Map<String, dynamic>>()
        .map((obj) => DepartmentsSelectList.fromMap(obj))
        .toList()
        .cast<DepartmentsSelectList>();
  }

  static DepartmentsSelectList fromMap(Map map) {
    return new DepartmentsSelectList(
      id: map['id'],
      name: map['name'],
    );
  }

  static String _capitalize(String input) {
    return input.substring(0, 1).toUpperCase() + input.substring(1);
  }
}
