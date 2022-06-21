import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertraining/AuthenticationModule/View/auth_btn.dart';

class LocaleView extends StatefulWidget {
  const LocaleView({Key? key}) : super(key: key);

  @override
  State<LocaleView> createState() => _LocaleViewState();
}

class _LocaleViewState extends State<LocaleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.arrow_back),
          SizedBox(height: 20),
          Text("This is testing project of language translation".tr),
          Text("change language tu other".tr),
          Text("Testing".tr),
          SizedBox(height: 20),
          AuthBTN(
            callback: () {
              Get.updateLocale(Locale("en", "US"));
            },
            title: "English",
          ),
          SizedBox(height: 20),
          AuthBTN(
            callback: () {
              Get.updateLocale(Locale("ar", "AE"));
            },
            title: "Arabic",
          ),
        ],
      ),
    ));
  }
}
