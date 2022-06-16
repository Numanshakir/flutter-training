import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertraining/ChatModule/Service/get_stoarage_handler.dart';
import 'package:fluttertraining/ChatModule/View/show_message.dart';
import 'package:get/get.dart';

class FirebaseServices extends GetxController {
  checkUserExsitence({required String docID}) async {
    ///is Exist
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc("numanshakir248@gmail.com")
        .get();
    if (snapshot.exists) {}

    ///Future
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc("cbkjbcsdjbcs")
        .get();
    documentSnapshot.id;
    documentSnapshot.get("field");

    // QuerySnapshot querySnapshot =
    // await FirebaseFirestore.instance.collection("users").where("members.${userID}").get();
    // QuerySnapshot querySnapshot =
    //     await FirebaseFirestore.instance.collection("users").where("status",isEqualTo: true).get();
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("users").get();

    for (int index = 0; index < querySnapshot.docs.length; index++) {
      querySnapshot.docs[index].id;
      querySnapshot.docs[index].get("field");
    }

    ///Future
    Stream<DocumentSnapshot<Map<String, dynamic>>> documentSnapshot1 =
        FirebaseFirestore.instance
            .collection("users")
            .doc("cbkjbcsdjbcs")
            .snapshots();

    documentSnapshot1.listen((event) {
      event.get("field");
    });

    Stream<QuerySnapshot<Map<String, dynamic>>> querySnapshot1 =
        FirebaseFirestore.instance.collection("users").snapshots();
  }
}

addUserService({required String email, required BuildContext context}) async {
  DocumentSnapshot snapshot =
      await FirebaseFirestore.instance.collection("users").doc(email).get();
  if (snapshot.exists) {
    final userEmail = await GetStorageHandler().getEmail();

    await FirebaseFirestore.instance
        .collection("users")
        .doc(userEmail)
        .collection("inbox")
        .doc(email)
        .set({
      "email": email,
    }, SetOptions(merge: true));
    await FirebaseFirestore.instance
        .collection("users")
        .doc(email)
        .collection("inbox")
        .doc(userEmail)
        .set({
      "email": email,
    }, SetOptions(merge: true));
    ShowMessage().showMessage(context, "User Added Successfully");
  } else {
    ShowMessage().showErrorMessage(context, "User Not Found");
  }
}

saveUser({required String email}) async {
  await FirebaseFirestore.instance.collection("users").doc(email).set({
    "email": email,
  });
}
