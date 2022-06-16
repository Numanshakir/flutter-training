import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertraining/AuthenticationModule/View/auth_btn.dart';

class FireDatabaseView extends StatefulWidget {
  final String name;
  final String email;
  final String url;

  FireDatabaseView(
      {Key? key, required this.email, required this.name, required this.url})
      : super(key: key);

  @override
  _FireDatabaseViewState createState() => _FireDatabaseViewState();
}

class _FireDatabaseViewState extends State<FireDatabaseView> {
  String name = "";
  String email = "";
  String url = "";

  setDataToFirebase() async {
    var data = {
      "name": widget.name,
      "email": widget.email,
      "photoURL": widget.url,
    };
    var response = await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.email)
        .set(data);
  }

  getDataFromFirebase() async {
    var response = await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.email)
        .get();
    var data = response.data();
    setState(() {
      name = data!["name"];
      email = data["email"];
      url = data["photoURL"];
    });
  }

  getAllUsersDataFromFirebase() async {
    var response = await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.email)
        .get();
    var data = response.data();
    setState(() {
      name = data!["name"];
      email = data["email"];
      url = data["photoURL"];
    });
  }

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
            title: "Set Data to Firebase",
            callback: () async {
              setDataToFirebase();
            },
          ),
          SizedBox(
            height: 50,
          ),
          AuthBTN(
            title: "Get Data From Firebase",
            callback: () async {
              getDataFromFirebase();
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
        ],
      ),
    ));
  }
}
