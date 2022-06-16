import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertraining/StateManagementModule/test_view_model.dart';
import 'package:get/get.dart';

class StateViewController extends StatelessWidget {
  StateViewController({Key? key}) : super(key: key);
  final testVM = TestViewModel();

  // final testVM = Get.put(TestViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            testVM.onCounterIncrease();
          },
        ),
        appBar: AppBar(title: Text("State Management")),
        body: Container(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => Text("Count ${testVM.counter.value} "),
              ),
              Text("Count ${testVM.counter.value} "),
            ],
          ),
        ));
  }
}
