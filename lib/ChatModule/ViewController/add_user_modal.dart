import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertraining/AuthenticationModule/View/auth_btn.dart';
import 'package:fluttertraining/ChatModule/Service/firebase_services.dart';
import 'package:fluttertraining/ChatModule/View/show_message.dart';
import 'package:fluttertraining/ChatModule/ViewModel/inbox_view_model.dart';
import 'package:get/get.dart';

addUserModal(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final inboxVM = Get.put(InboxViewModel());
  return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            height: 160,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: inboxVM.emailController.value,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  AuthBTN(
                    title: "Add User",
                    callback: () async {
                      if (inboxVM.emailController.value.text.isNotEmpty) {
                        await addUserService(
                            email: inboxVM.emailController.value.text,
                            context: context);
                        Get.back();
                      } else {
                        ShowMessage().showErrorMessage(context, "Enter email");
                      }
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
