class Profile {
  final String fullName;
  final String dateOfBirth;
  final String description;
  final String factualAddress;
  final String genderName;
  final String hireDate;
  final String departmentName;
  final String positionName;
  final String phone;
  final String email;
  final String photoPath;
  final String photoPathSmall;

  Profile({
    this.fullName,
    this.dateOfBirth,
    this.description,
    this.factualAddress,
    this.genderName,
    this.hireDate,
    this.departmentName,
    this.positionName,
    this.phone,
    this.email,
    this.photoPath,
    this.photoPathSmall,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      fullName: json['data']['fullName'],
      dateOfBirth: json['data']['dateOfBirth'],
      description: json['data']['description'],
      factualAddress: json['data']['factualAddress'],
      genderName: json['data']['genderName'],
      hireDate: json['data']['hireDate'],
      departmentName: json['data']['departmentName'],
      positionName: json['data']['positionName'],
      phone: json['data']['phone'],
      email: json['data']['email'],
      photoPath: json['data']['photoPath'],
      photoPathSmall: json['data']['photoPathSmall'],
    );
  }
}
