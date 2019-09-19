class MiniProfile {
  final String name;
  final String position;
  final String photo;

  MiniProfile({
    this.name,
    this.position,
    this.photo,
  });

  factory MiniProfile.fromJson(Map<String, dynamic> json) {
    return MiniProfile(
      name: json['name'],
      position: json['position'],
      photo: json['photo'],
    );
  }
}
