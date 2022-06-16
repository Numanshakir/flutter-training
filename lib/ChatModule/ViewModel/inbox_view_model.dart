import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertraining/ChatModule/Service/get_stoarage_handler.dart';
import 'package:get/get.dart';

class InboxViewModel extends GetxController {
  Rx<TextEditingController> emailController = TextEditingController().obs;

  RxList<String> users = <String>[].obs;

  fetchUsers() async {
    final userID = await GetStorageHandler().getEmail();
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshot = FirebaseFirestore
        .instance
        .collection("users")
        .doc(userID)
        .collection("inbox")
        .snapshots();
    snapshot.listen((event) {
      users.value = event.docs.map((e) => "${e["email"]}").toList();
    });
  }
}
