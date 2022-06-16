import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertraining/AuthenticationModule/View/auth_btn.dart';

class NavBarView extends StatefulWidget {
  NavBarView({Key? key}) : super(key: key);

  @override
  State<NavBarView> createState() => _NavBarViewState();
}

class _NavBarViewState extends State<NavBarView> {
  int currentIndex = 0;
  List screens = <Widget>[
    NewScreen(),
    NewScreen1(),
    NewScreen(),
    NewScreen1(),
    NewScreen(),
  ];

  /// TODO: app bar
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Bottom Nav Bar"),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () {
              setState(() {
                currentIndex = 2;
              });
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          elevation: 15,
          notchMargin: 9,
          clipBehavior: Clip.antiAlias,
          // clipBehavior: Clip.antiAliasWithSaveLayer,
          // clipBehavior: Clip.hardEdge,
          shape: CircularNotchedRectangle(),

          child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavBarItem(
                calBack: () {
                  setState(() {
                    currentIndex = 0;
                  });
                },
              ),
              NavBarItem(
                calBack: () {
                  setState(() {
                    currentIndex = 1;
                  });
                },
              ),
              SizedBox(
                height: 60,
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 5,
              ),
              NavBarItem(
                calBack: () {
                  setState(() {
                    currentIndex = 3;
                  });
                },
              ),
              NavBarItem(
                calBack: () {
                  setState(() {
                    currentIndex = 4;
                  });
                },
              ),
            ],
          ),
        ),
        body: screens[currentIndex]);
  }
}
// itemBuilder: (context, index) {
// return Container(
// color: Colors.blue,
// child: Text("index: $index"),
// );
// },

class NavBarItem extends StatelessWidget {
  VoidCallback calBack;

  NavBarItem({Key? key, required this.calBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        calBack();
      },
      child: Container(
        height: 60,
        width: MediaQuery
            .of(context)
            .size
            .width / 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.person),
            Text("data"),
          ],
        ),
      ),
    );
  }
}

class NewScreen extends StatelessWidget {
  const NewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyan,
      child: Center(
        child: RichText(
          text: TextSpan(
              style: DefaultTextStyle
                  .of(context)
                  .style,
              children: <TextSpan>[
                TextSpan(
                    text: "Have already an account? ",
                    style: TextStyle(
                      color: Colors.black,
                    )),
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {},
                    text: "Sign In",
                    style: TextStyle(color: Colors.red, fontSize: 15)),
              ]),
        ),
        // child: Text("Have already an account? Sign In"),
      ),
    );
  }
}

class NewScreen1 extends StatefulWidget {
  const NewScreen1({Key? key}) : super(key: key);

  @override
  State<NewScreen1> createState() => _NewScreen1State();
}

class _NewScreen1State extends State<NewScreen1> {
  double heightC = 0;
  double widthC = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: MediaQuery
          .of(context)
          .size
          .height,
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            decoration: BoxDecoration(color: Colors.green),
            duration: Duration(seconds: 1),
            height: heightC,
            width: widthC,
            curve: Curves.slowMiddle,
            // curve: Curves.fastLinearToSlowEaseIn,
            // curve: Curves.easeOut,

            // curve: Curves.easeOut,
            // curve: Curves.decelerate,
            // curve: Curves.linear,
          ),
          SizedBox(
            height: 20,
          ),
          AuthBTN(
            callback: () {
              setState(() {
                if (heightC == 200) {
                  heightC = 100;
                  widthC = 100;
                } else {
                  heightC = 200;
                  widthC = 200;
                }
              });
            },
          )
        ],
      ),
    );
  }
}
