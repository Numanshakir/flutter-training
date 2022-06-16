import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewStackScreen extends StatelessWidget {
  const NewStackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("New Screen"),
      ),
      body: Container(
        color: Colors.black,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        child: Stack(
          // alignment: Alignment.center,
          children: [
            Align(
              // alignment: Alignment.topCenter,
              child: Container(
                height: 100,
                width: 300,
                color: Colors.red,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 10,
              child: Container(
                height: 100,
                width: 300,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
