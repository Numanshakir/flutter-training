import 'dart:convert';
import 'dart:io';

import 'package:fluttertraining/ApisModule/apis_model.dart';
import 'package:fluttertraining/LocalDB/local_db_handler.dart';
import 'package:http/http.dart' as http;

Future<List<BannerModel>> getDataService() async {
  List<BannerModel> apisModel = <BannerModel>[];
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

  if (response.statusCode == 200) {
    apisModel = BannerModel.jsonTestApiModelList(jsonDecode(response.body));
    if ((await DBProvider.db.checkDataExistenceByLength("Banners")) == 0) {
      await DBProvider.db.setBannersList(apisModel);
    } else {
      await DBProvider.db.deleteAllBanners();
      await DBProvider.db.setBannersList(apisModel);
    }
  }
  return apisModel;
}

///MultiPart API Services

Future uploadFile({required String url, required File imgFile}) async {
  var request = http.MultipartRequest(
    "POST",
    Uri.parse(url),
  );

  request.headers['accept'] = '*/*';
  request.headers["Content-Type"] = 'multipart/form-data';
  // request.headers["Authorization"] ='Bearer ${token}';

  request.fields["name"] = "numan";
  request.fields["email"] = "numan";
  // request.fields["name"] = name;

  var pic = await http.MultipartFile.fromPath("image", imgFile.path.trim());

  request.files.add(pic);
  var response = await request.send();
  var result = await http.Response.fromStream(response);
  // print(json.decode(result.body));
  return result;
}
