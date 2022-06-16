import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertraining/ChatModule/Model/message_model.dart';
import 'package:fluttertraining/ChatModule/Service/get_stoarage_handler.dart';
import 'package:get/get.dart';

class ChatViewModel extends GetxController {
  Rx<TextEditingController> textController = TextEditingController().obs;
  RxList<MessageModel> messages = <MessageModel>[].obs;

  getMessages({required String userEmail}) async {
    final userID = await GetStorageHandler().getEmail();
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshot = FirebaseFirestore
        .instance
        .collection("users")
        .doc(userID)
        .collection("inbox")
        .doc(userEmail)
        .collection("messages")
        .orderBy("createdOn",descending: true)
        .snapshots();
    snapshot.listen((event) {
      if (MessageModel.firebaseTOMessageModelList(
        event.docs,
      ).isNotEmpty)
        messages.value = MessageModel.firebaseTOMessageModelList(event.docs);
    });
  }

  sendMessage({required BuildContext context, required String userEmail}) async {
    final myID = await GetStorageHandler().getEmail();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(myID)
        .collection("inbox")
        .doc(userEmail)
        .collection("messages")
        .doc()
        .set({
      "text": textController.value.text,
      "createdOn": DateTime.now().millisecondsSinceEpoch,
      "email": myID,
    });

    await FirebaseFirestore.instance
        .collection("users")
        .doc(userEmail)
        .collection("inbox")
        .doc(myID)
        .collection("messages")
        .doc()
        .set({
      "text": textController.value.text,
      "createdOn": DateTime.now().millisecondsSinceEpoch,
      "email": myID,
    });
    textController.value.clear();
  }
}
