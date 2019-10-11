class EmployeePassport {
  final String passportNumber;
  final String passportIssuer;
  final String passportIssueDate;
  final String dateOfBirth;
  final String nationality;
  final String nationalityId;
  final String passportAddress;
  final String passportScanPath;

  EmployeePassport({
    this.passportNumber,
    this.passportIssuer,
    this.passportIssueDate,
    this.dateOfBirth,
    this.nationality,
    this.nationalityId,
    this.passportAddress,
    this.passportScanPath,
  });

  factory EmployeePassport.fromJson(Map<String, dynamic> json) {
    return EmployeePassport(
      passportNumber: json['data']['passportNumber'],
      passportIssuer: json['data']['passportIssuer'],
      passportIssueDate: json['data']['passportIssueDate'],
      dateOfBirth: json['data']['dateOfBirth'],
      nationality: json['data']['nationality'],
      nationalityId: json['data']['nationalityId'],
      passportAddress: json['data']['passportAddress'],
      passportScanPath: json['data']['passportScanPath'],
    );
  }
}
