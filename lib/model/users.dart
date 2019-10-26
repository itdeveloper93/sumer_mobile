import 'dart:convert';

class User {
  User({
    this.id,
    this.name,
  });

  final String id;
  final String name;

  static List<User> allFromResponse(String response) {
    var decodedJson = json.decode(response).cast<String, dynamic>();

    return decodedJson['data']
        .cast<Map<String, dynamic>>()
        .map((obj) => User.fromMap(obj))
        .toList()
        .cast<User>();
  }

  static User fromMap(Map map) {
    return new User(
      id: map['id'],
      name: map['name'],
    );
  }

  static String _capitalize(String input) {
    return input.substring(0, 1).toUpperCase() + input.substring(1);
  }
}
