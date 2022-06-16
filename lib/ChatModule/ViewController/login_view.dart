import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertraining/AuthenticationModule/View/auth_btn.dart';
import 'package:fluttertraining/ChatModule/Service/firebase_services.dart';
import 'package:fluttertraining/ChatModule/Service/get_stoarage_handler.dart';
import 'package:fluttertraining/ChatModule/Service/google_signin_service.dart';
import 'package:fluttertraining/ChatModule/ViewController/inbox_view_controller.dart';
import 'package:get/get.dart';

class ChatAuthViewController extends StatefulWidget {
  const ChatAuthViewController({Key? key}) : super(key: key);

  @override
  _ChatAuthViewControllerState createState() => _ChatAuthViewControllerState();
}

class _ChatAuthViewControllerState extends State<ChatAuthViewController> {
  final googleLoginVM = GoogleLoginService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: AuthBTN(
          title: "Google Sign In",
          callback: () async {
            UserCredential userCredential =
                await googleLoginVM.onGoogleSignIn();
            googleLoginVM.onGoogleLogout();

            if (userCredential != null) {
              await saveUser(email: userCredential.user!.email!);
              await GetStorageHandler().setEmail(userCredential.user!.email!);
              Get.offAll(() => InboxViewController(
                    email: userCredential.user!.email!,
                  ));
            }
          },
        ),
      ),
    ));
  }
}
