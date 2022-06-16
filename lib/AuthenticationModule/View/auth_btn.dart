import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Widget authBTN(){
//   return   MaterialButton(
//     height: 50,
//     color: Colors.red,
//
//     onPressed: () {
//
//     },
//
//
//
//   );
// }
class AuthBTN extends StatelessWidget {
  String title;
  // Function callback;
  VoidCallback callback;
  AuthBTN({Key? key, this.title="",required this.callback}) : super(key: key);
  // AuthBTN({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialButton(
      height: 50,

      color: Colors.red,

      onPressed: (){
        callback();
      },

child: Text(title),

    );
  }
}
