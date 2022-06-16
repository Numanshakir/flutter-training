
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertraining/ChatModule/Service/google_signin_service.dart';
import 'package:fluttertraining/ChatModule/ViewModel/chat_view_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatScreenView extends StatefulWidget {
  final String userEmail;

  ChatScreenView({Key? key, required this.userEmail}) : super(key: key);

  @override
  _ChatScreenViewState createState() => _ChatScreenViewState();
}

class _ChatScreenViewState extends State<ChatScreenView> {
  final googleLoginVM = GoogleLoginService();
  final chatVM = ChatViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatVM.getMessages(userEmail: widget.userEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.userEmail),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Obx(() => Expanded(
                      child: ListView.builder(
                        reverse: true,
                        itemCount: chatVM.messages.value.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: chatVM.messages.value[index].email !=
                                          widget.userEmail
                                      ? Colors.blue
                                      : Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      blurRadius: 4,
                                      spreadRadius: 2,
                                    )
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(chatVM.messages[index].text +
                                    " " +
                                    "${DateFormat.EEEE().add_jm().format(DateTime.fromMillisecondsSinceEpoch(chatVM.messages[index].createdOn)).toUpperCase()}"),
                              ),
                            ),
                          );
                        },
                      ),
                    )),
                SizedBox(
                  height: 60,
                  child: Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                        controller: chatVM.textController.value,
                      )),
                      IconButton(
                          onPressed: () async {
                            if (chatVM.textController.value.text.isNotEmpty) {
                              await chatVM.sendMessage(
                                  context: context,
                                  userEmail: widget.userEmail);
                            }
                          },
                          icon: Icon(Icons.send)),
                    ],
                  ),
                ),
              ],
            )));
  }
}
