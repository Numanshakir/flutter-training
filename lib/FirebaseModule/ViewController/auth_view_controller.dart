import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertraining/ApisModule/service.dart';
import 'package:fluttertraining/AuthenticationModule/View/auth_btn.dart';
import 'package:fluttertraining/FirebaseModule/Services/firebase_stoarge_service.dart';
import 'package:fluttertraining/ChatModule/Service/google_signin_service.dart';
import 'package:fluttertraining/FirebaseModule/View/ImagePicker.dart';
import 'package:fluttertraining/FirebaseModule/ViewController/firebase_database_view.dart';
import 'package:fluttertraining/FirebaseModule/ViewController/firebase_testing.dart';

class GoogleAuth extends StatefulWidget {
  const GoogleAuth({Key? key}) : super(key: key);

  @override
  _GoogleAuthState createState() => _GoogleAuthState();
}

class _GoogleAuthState extends State<GoogleAuth> {
  String name = "";
  String email = "";
  String url = "";
  final googleLoginVM = GoogleLoginService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (url.isNotEmpty)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image: NetworkImage(url),
                  height: 100,
                  width: 80,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(name),
                SizedBox(
                  height: 20,
                ),
                Text(email),
              ],
            ),
          SizedBox(
            height: 50,
          ),
          AuthBTN(
            title: "Upload Image",
            callback: () async {
              CustomImagePicker().showPicker(
                  context: context,
                  onGetImage: (val) async {


                    uploadFile(url: "url", imgFile: File(val));

                    // String image = await FireStorageImageService()
                    //     .uploadImageToFirebase(context, val);
                    // setState(() {
                    //   url = image;
                    // });
                  });
            },
          ),
          SizedBox(
            height: 50,
          ),
          AuthBTN(
            title: "Google Sign In",
            callback: () async {
              UserCredential user = await googleLoginVM.onGoogleSignIn();
              googleLoginVM.onGoogleLogout();
              print(user);
              print(user);
              setState(() {
                url = user.user!.providerData.first.photoURL!;
                email = user.user!.providerData.first.email!;
                name = user.user!.providerData.first.displayName!;
              });

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FireDataView(
                        userModel:
                            UserModel(email: email, name: name, photoURL: url)),
                  ));
            },
          ),
          // SizedBox(
          //   height: 50,
          // ),
          // AuthBTN(
          //   title: "FaceBook Sign In",
          //   callback: () async {
          //     UserCredential user = await signInWithFacebook();
          //     print(user);
          //     print(user);
          //     setState(() {
          //       url = user.user!.providerData.first.photoURL!;
          //       email = user.user!.providerData.first.email!;
          //       name = user.user!.providerData.first.displayName!;
          //     });
          //   },
          // ),
          SizedBox(
            height: 20,
          ),
          AuthBTN(
            title: "Log Out",
            callback: () async {
              await googleLoginVM.onGoogleLogout();
            },
          ),
        ],
      ),
    ));
  }

  signInWithFacebook() async {
    // try {
    final loginCredentail = await FacebookAuth.instance.login(
      permissions: ['public_profile', 'email'],
    );
    if (loginCredentail != null) {
      print("Fb User");
      final credential =
          FacebookAuthProvider.credential(loginCredentail.accessToken!.token);

      return await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
    }
    // } catch (e) {
    //   print("e");
    //   print(e.toString().contains("credential-already-in-use"));
    //   if (e.toString().contains("credential-already-in-use")) {
    //     return "both";
    //   }
    // }
  }
}
