import 'package:fluttertraining/ApisModule/apis_model.dart';
import 'package:fluttertraining/ApisModule/service.dart';
import 'package:fluttertraining/LocalDB/local_db_handler.dart';
import 'package:get/get.dart';

class TestApis extends GetxController {
  RxList<BannerModel> apisModelListData = <BannerModel>[].obs;

  Future<List<BannerModel>> fetchData() async {
    List<BannerModel> apisModel = <BannerModel>[];
    if ((await DBProvider.db.checkDataExistenceByLength("Banners")) == 0) {
      print("fetch data from API");
      apisModel = await getDataService();
    } else {
      print("fetch data from local");
      apisModel = await DBProvider.db.getBannersList();
      getDataService().then((value) => {
      if(value.isNotEmpty){
          print("fetch data from background"),
          apisModelListData.value=value,
      }


      });
    }

    apisModelListData.value = apisModel;
    return apisModel;
  }
}
