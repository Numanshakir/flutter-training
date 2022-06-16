import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertraining/ChatModule/Service/get_stoarage_handler.dart';
import 'package:fluttertraining/ChatModule/ViewController/inbox_view_controller.dart';
import 'package:fluttertraining/ChatModule/ViewController/login_view.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      checkUser();
    });
  }

  checkUser() async {
    final email = await GetStorageHandler().getEmail();
    if (email != null) {
      Get.offAll(() => InboxViewController(
            email: email,
          ));
    } else {
      Get.offAll(() => ChatAuthViewController());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        color: Colors.white,
        child: Text("Chat"),
      ),
    ));
  }
}
