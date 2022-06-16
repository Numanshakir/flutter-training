import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Wrape_View extends StatefulWidget {
  Wrape_View({Key? key}) : super(key: key);

  @override
  State<Wrape_View> createState() => _Wrape_ViewState();
}

class _Wrape_ViewState extends State<Wrape_View> {
  /// TODO: app bar
  List<String> items = [
    "Numan Shakir",
    "Usman Tahir Usman Tahis",
    "Zaman",
    "Numan Shakir",
    "Usman Tahir Usman Tahis",
    "Zaman",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Wrape")),
        body: Container(
          color: Colors.blue,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Wrap(
            spacing: 10,
            // runSpacing: 20,
            // crossAxisAlignment: WrapCrossAlignment.start,
            // alignment: Wra pAlignment.spaceAround,
            children: items
                .map((e) => Container(
                      height: 100,
                      color: Colors.red,
                      // width: 100,
                      child: Center(
                        child: Text(e),
                      ),
                    ))
                .toList(),
            clipBehavior: Clip.hardEdge,
            // clipBehavior: Clip.antiAliasWithSaveLayer,
            // clipBehavior: Clip.antiAlias,
            // clipBehavior: Clip.,
            // crossAxisAlignment: WrapCrossAlignment.,
            direction: Axis.vertical,
            runAlignment: WrapAlignment.start,
// verticalDirection: VerticalDirection.up,
// verticalDirection: VerticalDirection.down,
// direction: Axis.horizontal,
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
