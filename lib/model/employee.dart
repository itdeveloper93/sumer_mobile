class Employee {
  final String id;
  final String fullName;
  final String photoPath;
  final String photoPathSmall;
  final String department;
  final String position;
  final String userId;
  final String phone;
  final String email;
  final String firstName;
  final String lastName;
  final String middleName;
  final String dateOfBirth;
  final String description;
  final String factualAddress;
  final String genderName;
  final String hireDate;
  final String employeeLockReasonName;
  final String lockDate;
  final String lockAuthor;
  final String genderId;
  final String departmentId;
  final String positionId;
  final String lastModifiedAuthor;
  final String lastModifiedAt;
  final String lastEditedAt;

  Employee({
    this.id,
    this.fullName,
    this.photoPath,
    this.photoPathSmall,
    this.department,
    this.position,
    this.userId,
    this.phone,
    this.email,
    this.firstName,
    this.lastName,
    this.middleName,
    this.dateOfBirth,
    this.description,
    this.factualAddress,
    this.genderName,
    this.hireDate,
    this.employeeLockReasonName,
    this.lockDate,
    this.lockAuthor,
    this.genderId,
    this.departmentId,
    this.positionId,
    this.lastModifiedAuthor,
    this.lastModifiedAt,
    this.lastEditedAt,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['data']['id'],
      fullName: json['data']['fullName'],
      photoPath: json['data']['photoPath'],
      photoPathSmall: json['data']['photoPathSmall'],
      department: json['data']['department'],
      position: json['data']['position'],
      userId: json['data']['userId'],
      phone: json['data']['phone'],
      email: json['data']['email'],
      firstName: json['data']['firstName'],
      lastName: json['data']['lastName'],
      middleName: json['data']['middleName'],
      dateOfBirth: json['data']['dateOfBirth'],
      description: json['data']['description'],
      factualAddress: json['data']['factualAddress'],
      genderName: json['data']['genderName'],
      hireDate: json['data']['hireDate'],
      employeeLockReasonName: json['data']['employeeLockReasonName'],
      lockDate: json['data']['lockDate'],
      lockAuthor: json['data']['lockAuthor'],
      genderId: json['data']['genderId'],
      departmentId: json['data']['departmentId'],
      positionId: json['data']['positionId'],
      lastModifiedAuthor: json['data']['lastModifiedAuthor'],
      lastModifiedAt: json['data']['lastModifiedAt'],
      lastEditedAt: json['data']['lastEditedAt'],
    );
  }
}
