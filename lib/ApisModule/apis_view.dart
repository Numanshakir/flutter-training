import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertraining/ApisModule/apis_model.dart';
import 'package:fluttertraining/ApisModule/service.dart';
import 'package:fluttertraining/ApisModule/view_model_apis.dart';
import 'package:fluttertraining/LocalDB/local_db_handler.dart';
import 'package:get/get.dart';

class TextApis extends StatefulWidget {
  const TextApis({Key? key}) : super(key: key);

  @override
  State<TextApis> createState() => _TextApisState();
}

class _TextApisState extends State<TextApis> {
  Future<List<BannerModel>>? fetchData;
  final apiVM = TestApis();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createLocalDB();
    fetchData = apiVM.fetchData();
  }

  void createLocalDB() async {
    if (await DBProvider.db.databaseExists()) {
      print("local db exsit");
    } else {
      print("local db not exsit");
      await DBProvider.db.initDB();
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch Data Example'),
      ),
      body: Center(
        child: FutureBuilder<List<BannerModel>>(
          future: fetchData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Obx(() => ListView.builder(
                    itemCount: apiVM.apisModelListData.value.length,
                    itemBuilder: (context, index) {
                      return Text(apiVM.apisModelListData.value[index].title);
                    },
                  ));
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
