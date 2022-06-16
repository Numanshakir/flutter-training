// class BannerModel {
//   String id;
//   int status;
//   String store_id;
//   String type;
//   String image_urls;
//
//   BannerModel({
//     required this.id,
//     required this.status,
//     required this.type,
//     required this.image_urls,
//     required this.store_id,
//   });
//
//   factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
//     id: json["id"] ?? "",
//     status: json["status"] ?? 0,
//     image_urls: json["image_urls"]["banner"] ?? '',
//     store_id: json["store_id"] ?? "",
//     type: json["type"] ?? "",
//   );
//
//   factory BannerModel.fromLocal(Map<String, dynamic> json) => BannerModel(
//     id: json["id"] ?? "",
//     status: json["status"] ?? 0,
//     image_urls: json["image_urls"] ?? '',
//     store_id: json["store_id"] ?? "",
//     type: json["type"] ?? "",
//   );
//
//   static List<BannerModel> jsonToBannerModel(List<dynamic> emote) =>
//       emote.map<BannerModel>((item) => BannerModel.fromJson(item)).toList();
//
//   static List<BannerModel> localToBannerModel(List<dynamic> emote) =>
//       emote.map<BannerModel>((item) => BannerModel.fromLocal(item)).toList();
// }