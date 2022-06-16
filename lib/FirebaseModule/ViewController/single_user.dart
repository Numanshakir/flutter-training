import 'package:flutter/material.dart';
import 'package:fluttertraining/FirebaseModule/ViewController/firebase_testing.dart';

class SingleUsersInfoList extends StatefulWidget {
  final UserModel userModel;

  SingleUsersInfoList({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  _SingleUsersInfoListState createState() => _SingleUsersInfoListState();
}

class _SingleUsersInfoListState extends State<SingleUsersInfoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child:
          ListTile(
            title: Text("${widget.userModel.name}"),
            leading: Text("${widget.userModel.email}"),
            subtitle: Text("${widget.userModel.photoURL}"),
          ),
        ));
  }
}
