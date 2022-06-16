import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertraining/AuthenticationModule/View/auth_btn.dart';
import 'package:fluttertraining/FirebaseModule/ViewController/users_list_view.dart';

class FireDataView extends StatefulWidget {
  final UserModel userModel;

  FireDataView({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  _FireDataViewState createState() => _FireDataViewState();
}

class _FireDataViewState extends State<FireDataView> {
  setData() async {
    Map<String, dynamic> data = {
      "name": widget.userModel.name,
      "photoURL": widget.userModel.photoURL,
      "email": widget.userModel.email,
    };

    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.userModel.email)
        .set(data);
  }

  updateData() async {
    Map<String, dynamic> data = {
      "name": "Usama",
      "photoURL": widget.userModel.photoURL,
      "email": "Usama@gmail.com",
    };

    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.userModel.email)
        .update(data);
  }

  getData() async {
    DocumentSnapshot data = await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.userModel.email)
        .get();
    UserModel userModel;
    userModel = UserModel.fromJson(data);
    print(userModel.photoURL);
    print(userModel.name);
    print(userModel.email);
  }

  getAllUsersData() async {
    QuerySnapshot result =
        await FirebaseFirestore.instance.collection("users").get();

    List<UserModel> users = <UserModel>[];
    users = UserModel.jsonToUserModelList(result.docs);
    if (users.isNotEmpty) {
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => UsersInfoList(users: users),
      //     ));

      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => UsersInfoList(
      //           users:
      //               users.where((element) => element.name != "usama").toList()),
      //     ));
    }
    // for (int index = 0; index < users.length; index++) {
    //   print(userModelToJson(users[index]));
    // }
  }

  deleteData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.userModel.email)
        .delete();
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
          SizedBox(
            height: 50,
          ),
          AuthBTN(
            title: "Set Data To Firebase",
            callback: () async {
              setData();
            },
          ),
          SizedBox(
            height: 50,
          ),
          AuthBTN(
            title: "Get Data From Firebase",
            callback: () async {
              getData();
            },
          ),
          SizedBox(
            height: 50,
          ),
          AuthBTN(
            title: "Update Data From Firebase",
            callback: () async {
              updateData();
            },
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
          ),
          AuthBTN(
            title: "Delete Data From Firebase",
            callback: () async {
              deleteData();
            },
          ),
          SizedBox(
            height: 20,
          ),
          AuthBTN(
            title: "GEt All  Data From Firebase",
            callback: () async {
              getAllUsersData();
            },
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    ));
  }
}

class UserModel {
  String name;
  String email;
  String photoURL;

  UserModel({required this.email, required this.name, required this.photoURL});

  factory UserModel.fromJson(DocumentSnapshot json) => UserModel(
        name: (json.data() as dynamic)["name"] ?? "",
        email: (json.data() as dynamic)["email"] ?? "",
        photoURL: (json.data() as dynamic)["photoURL"] ?? "",
      );

  static List<UserModel> jsonToUserModelList(List<DocumentSnapshot> jsonList) =>
      jsonList.map<UserModel>((item) => UserModel.fromJson(item)).toList();

  static List<UserModel> snapToUserModelList(List<DocumentSnapshot> docs) {
    return docs.map<UserModel>(
      (doc) {
        return UserModel.fromJson(doc);
      },
    ).toList();
  }
//
// static List<UserModel> snapToUserModelList(List<DocumentSnapshot> jsonList) =>
//     jsonList.map<UserModel>((item) => UserModel.fromJson(item)).toList();
//

}

Map<String, dynamic> userModelToJson(UserModel userModel) => {
      "name": userModel.name,
      "email": userModel.email,
      "photoURL": userModel.photoURL,
    };

List<UserModel> jsonToUserModelList() {
  List<UserModel> newList = [];
  List<dynamic> oldList = [
    {
      "name": "Numan SHakir",
      "email": "numanshakir@gmail.com",
      "photoURL": "cbbcdcmcjkscbasdkcbcbccbsccbc",
    },
    {
      "name": "Numan SHakir",
      "email": "numanshakir@gmail.com",
      "photoURL": "cbbcdcmcjkscbasdkcbcbccbsccbc",
    },
    {
      "name": "Numan SHakir",
      "email": "numanshakir@gmail.com",
      "photoURL": "cbbcdcmcjkscbasdkcbcbccbsccbc",
    },
    {
      "name": "Numan SHakir",
      "email": "numanshakir@gmail.com",
      "photoURL": "cbbcdcmcjkscbasdkcbcbccbsccbc",
    },
  ];
  for (int index = 0; index < oldList.length; index++) {
    newList.add(UserModel.fromJson(oldList[index]));
    // newList.add(UserModel.fromJson(oldList[index]));

    // newList.add(UserModel(
    //     email: oldList[index]["email"],
    //     name: oldList[index]["name"],
    //     photoURL: oldList[index]["photoURL"]));
  }
  return newList;
}

// int a=5;
// int b=3;
//
// a=a+b;
// b=a-b;
// a=a-b;
//
//
// a,b=b,a
