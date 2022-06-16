import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertraining/AuthenticationModule/View/auth_btn.dart';
import 'package:fluttertraining/Enums/gender_enum.dart';

class CustomBTN extends StatefulWidget {
  CustomBTN({Key? key}) : super(key: key);

  @override
  State<CustomBTN> createState() => _CustomBTNState();
}

class _CustomBTNState extends State<CustomBTN> {
  genderSelector gender = genderSelector.female;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AuthBTN(
            title: "Time Picker",
            callback: ()async {
              final time =await  showTimePicker(
                  context: context, initialTime: TimeOfDay.now());
              print(time);
              // final time= TimePickerDialog(initialTime: TimeOfDay.now());
            },
          ),
          SizedBox(
            height: 50,
          ),
          AuthBTN(
            title: "Date Picker",
            callback: () async{
              final date =await  showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2050));
              print(date);
            },
          ),

          // Radio<genderSelector>(
          //   value: genderSelector.male,
          //   groupValue: gender,
          //   onChanged: (value) {
          //     setState(() {
          //       gender = value!;
          //     });
          //   },
          // ),
          // Radio<genderSelector>(
          //   value: genderSelector.female,
          //   groupValue: gender,
          //   onChanged: (value) {
          //     setState(() {
          //       gender = value!;
          //     });
          //   },
          // ),
        ],
      ),
    ));
  }
}
