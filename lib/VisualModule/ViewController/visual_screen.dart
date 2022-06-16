import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertraining/AuthenticationModule/View/auth_btn.dart';
import 'package:fluttertraining/Enums/gender_enum.dart';

/*
in this class we are using listview ... builder +custom+seperated

 */
class VisualScreen extends StatefulWidget {
  VisualScreen({Key? key}) : super(key: key);

  @override
  State<VisualScreen> createState() => _VisualScreenState();
}

class _VisualScreenState extends State<VisualScreen> {
  genderSelector gender = genderSelector.female;

  /// TODO: app bar
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Visual")),
        body: Container(
          color: Colors.blue,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          // child: ListView(
          //   // physics: NeverScrollableScrollPhysics(),
          //   // physics: BouncingScrollPhysics(),
          //   children: [
          //
          //
          //   ],
          // ),

          // child: ListView.builder(
          //   itemCount: 2,
          //   itemBuilder: (context, index) {
          //     return Container(
          //       height: 100,
          //       width: MediaQuery.of(context).size.width - 40,
          //       color: Colors.red,
          //     );
          //   },
          // ),
          child: ListView.separated(
            itemCount: 12,
            // physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 10,
                width: MediaQuery.of(context).size.width - 40,
              );
            },
            itemBuilder: (context, index) {
              return ListTile(

                tileColor: Colors.red,
                subtitle:Text("this is testing "),
                title: Text("tiltie "),
              );
              // return Container(
              //   height: 100,
              //   width: MediaQuery.of(context).size.width - 40,
              //   color: Colors.red,
              // );
            },
          ),
        ));
  }
}
