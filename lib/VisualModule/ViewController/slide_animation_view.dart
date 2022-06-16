import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertraining/AuthenticationModule/View/auth_btn.dart';

class SlideAnimationView extends StatefulWidget {
  const SlideAnimationView({Key? key}) : super(key: key);

  @override
  _SlideAnimationViewState createState() => _SlideAnimationViewState();
}

class _SlideAnimationViewState extends State<SlideAnimationView>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<Offset>? offset;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    offset = Tween<Offset>(
      begin: Offset(0, -3),
      end: Offset(0, 0.05),
    ).animate(controller!);

    ///TODO Y axis
    // offset = Tween<Offset>(
    //   begin: Offset(0, -3),
    //   end: Offset(0, 0.05),
    // ).animate(controller!);


    ///TODO X axis
    // offset = Tween<Offset>(
    //   begin: Offset(-5, 0),
    //   end: Offset(0.03, 0),
    // ).animate(controller!);

    // controller!.reverse();
    controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SlideTransition(
            position: offset!,
            child: Container(
              height: 100,
              width: 300,
              color: Colors.green,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          AuthBTN(
            callback: () {
              setState(() {
                print(controller!.status);
                if(controller!.status==AnimationStatus.completed){
                  controller!.reverse();
                }else{

                  controller!.forward();
                }

                // controller!.forward();
                // controller!.reverse();
                // controller!.repeat();
              });
            },
          )
        ],
      ),
    ));
  }
}


class FunkyOverlay extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => FunkyOverlayState();
}

class FunkyOverlayState extends State<FunkyOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController ?controller;
  Animation<double> ?scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    scaleAnimation =
        CurvedAnimation(parent: controller!, curve: Curves.decelerate);

    controller!.addListener(() {
      setState(() {});
    });

    controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: scaleAnimation!,
          child:Container(
            height: 100,
            width: 300,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}