import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertraining/AuthenticationModule/View/auth_btn.dart';
import 'package:fluttertraining/Enums/gender_enum.dart';

/*
in this class we are using listview ... builder +custom+seperated

 */
class GridViewCreen extends StatefulWidget {
  GridViewCreen({Key? key}) : super(key: key);

  @override
  State<GridViewCreen> createState() => _GridViewCreenState();
}

class _GridViewCreenState extends State<GridViewCreen> {
  /// TODO: app bar
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("GridView")),
        body: Container(
          color: Colors.blue,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: GridView.builder(

            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1.4,
              // mainAxisExtent:4,
            ),
            itemCount: 10,
            // scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                height: 100,
                color: Colors.red,
                width: 100,
              );
            },
          ),
        ));
  }
}
// itemBuilder: (context, index) {
// return Container(
// color: Colors.blue,
// child: Text("index: $index"),
// );
// },
