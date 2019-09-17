class User {
  String email;

  User({
    this.email,
  });

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    Map json = parsedJson['user'];
    return User(
      email: json['email'],
    );
  }
}
