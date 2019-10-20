class NewsDetailModel {
  final String id;
  final String title;
  final String shortDescription;
  final String description;
  final String publishAt;
  final String newsCategoryId;
  final String newsCategoryName;
  final String imagePath;
  final bool isActive;
  final String fullName;
  final String photoPath;
  final String employeeId;
  final String positionName;

  NewsDetailModel(
      {this.id,
      this.title,
      this.shortDescription,
      this.description,
      this.publishAt,
      this.newsCategoryId,
      this.newsCategoryName,
      this.imagePath,
      this.isActive,
      this.fullName,
      this.photoPath,
      this.employeeId,
      this.positionName});

  factory NewsDetailModel.fromJson(Map<String, dynamic> json) {
    return NewsDetailModel(
      id: json['data']['id'],
      title: json['data']['title'],
      shortDescription: json['data']['shortDescription'],
      description: json['data']['description'],
      publishAt: json['data']['publishAt'],
      newsCategoryId: json['data']['newsCategoryId'],
      newsCategoryName: json['data']['newsCategoryName'],
      imagePath: json['data']['imagePath'],
      isActive: json['data']['isActive'],
      fullName: json['data']['author']['fullName'],
      photoPath: json['data']['author']['photoPath'],
      employeeId: json['data']['author']['employeeId'],
      positionName: json['data']['author']['positionName'],
    );
  }
}
