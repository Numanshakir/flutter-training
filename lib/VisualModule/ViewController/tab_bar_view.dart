import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavBarView extends StatefulWidget {
  BottomNavBarView({Key? key}) : super(key: key);

  @override
  State<BottomNavBarView> createState() => _BottomNavBarViewState();
}

class _BottomNavBarViewState extends State<BottomNavBarView>
    with TickerProviderStateMixin {
  TabController? _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = TabController(length: 3, vsync: this);
  }

  /// TODO: app bar
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Bottom Nav Bar"),
        ),
        body: Container(
          color: Colors.blue,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              // DefaultTabController(
              //
              //     length: 3,
              //     child: Tab(
              //       child: Text("Tab"),
              //
              //
              //
              //     )),
              SizedBox(
                height: 40,
                child: TabBar(
                    indicatorColor: Colors.black,
                    controller: _controller,
                    unselectedLabelColor: Colors.black,
                    unselectedLabelStyle: TextStyle(color: Colors.black),
                    // indicator: BoxDecoration(
                    //   color: Colors.cyan,
                    // ),
                    // indicatorSize: TabBarIndicatorSize.tab,
                    // indicatorSize: TabBarIndicatorSize.label,
                    tabs: <Tab>[
                      Tab(
                        child: Text("Tab1"),
                      ),
                      Tab(
                        child: Text("Tab2"),
                      ),
                      Tab(
                        child: Text("Tab3"),
                      ),
                    ]),
              ),
              Expanded(
                  child: TabBarView(controller: _controller, children: [
                Container(
                  height: 100,
                  color: Colors.red,
                  // width: 100,
                  child: Center(
                    child: Text("tab1"),
                  ),
                ),
                Container(
                  height: 100,
                  color: Colors.red,
                  // width: 100,
                  child: Center(
                    child: Text("tab2"),
                  ),
                ),
                Container(
                  height: 100,
                  color: Colors.red,
                  // width: 100,
                  child: Center(
                    child: Text("tab3"),
                  ),
                )
              ]))
            ],
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
