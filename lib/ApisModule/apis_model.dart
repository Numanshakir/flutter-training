class BannerModel {
  final int userId;
  final int id;
  final String title;

  const BannerModel({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      userId: json['userId'] ?? "",
      id: json['id'] ?? "",
      title: json['title'] ?? "",
    );
  }

  static List<BannerModel> jsonTestApiModelList(
    List<dynamic> emote,
  ) =>
      emote
          .map<BannerModel>((item) => BannerModel.fromJson(
                item,
              ))
          .toList();
}
