import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertraining/FirebaseModule/ViewController/firebase_testing.dart';
import 'package:fluttertraining/FirebaseModule/ViewController/single_user.dart';

class UsersInfoList extends StatefulWidget {
  // final List<UserModel> users;

  UsersInfoList({
    Key? key,
    // required this.users,
  }) : super(key: key);

  @override
  _UsersInfoListState createState() => _UsersInfoListState();
}

class _UsersInfoListState extends State<UsersInfoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
          child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("users").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                // if (snapshot.hasError){
                //
                // }
                //
                List<UserModel> users = <UserModel>[];
                if (snapshot.hasData) {
                  print("snapshot");
                  print(snapshot.data!.docs);

                  users = UserModel.jsonToUserModelList(snapshot.data!.docs);
                }
                print(users.length);
                users = users
                    .where((element) => element.name.toLowerCase() != "usama")
                    .toList();

                print(users
                    .where((element) => element.name.toLowerCase() != "usama")
                    .toList()
                    .length);

                // builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    Widget? listWidget;

                    listWidget = ListTile(
                      title: Text(users[index].name),
                      leading: Text(users[index].email),
                      subtitle: Text(users[index].photoURL),
                    );

                    return listWidget;
                  },
                );
              })),
    ));
  }
}
