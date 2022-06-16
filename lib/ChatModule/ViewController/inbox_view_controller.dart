import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertraining/AuthenticationModule/View/auth_btn.dart';
import 'package:fluttertraining/ChatModule/Service/get_stoarage_handler.dart';
import 'package:fluttertraining/ChatModule/Service/google_signin_service.dart';
import 'package:fluttertraining/ChatModule/ViewController/add_user_modal.dart';
import 'package:fluttertraining/ChatModule/ViewController/chat_screen.dart';
import 'package:fluttertraining/ChatModule/ViewController/login_view.dart';
import 'package:fluttertraining/ChatModule/ViewModel/inbox_view_model.dart';
import 'package:get/get.dart';

class InboxViewController extends StatefulWidget {
  final String email;

  InboxViewController({Key? key, required this.email}) : super(key: key);

  @override
  _InboxViewControllerState createState() => _InboxViewControllerState();
}

class _InboxViewControllerState extends State<InboxViewController> {
  final googleLoginVM = GoogleLoginService();
  final inBoxVM = Get.put(InboxViewModel());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inBoxVM.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Inbox"), actions: [
          InkWell(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                await GetStorageHandler().removeEmail();
                Get.offAll(() => ChatAuthViewController());
              },
              child: Center(child: Text("LogOut"))),
          SizedBox(
            width: 20,
          ),
        ]),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              addUserModal(context);
            },
            tooltip: "Add User",
            child: Icon(Icons.add)),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Obx(() => ListView.builder(
                  itemCount: inBoxVM.users.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Get.to(() =>
                              ChatScreenView(userEmail: inBoxVM.users[index]));
                        },
                        child: Container(
                          decoration:
                              BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 4,
                              spreadRadius: 2,
                            )
                          ]),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                              child: Text(inBoxVM.users[index]),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ))));
  }
}
