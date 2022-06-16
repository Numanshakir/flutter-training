import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  String hintTxt;
  bool isPassword;
  TextInputType inputType;
  TextEditingController controller;

  InputField({
    Key? key,
    required this.hintTxt,
    required this.controller,
    this.isPassword = false,
    required this.inputType,
  }) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  String name = "Numan";
  bool isObsure = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if(widget.isPassword ==true){
    //   setState(() {
    //     isObsure=true;
    //   });
    // }
    print(widget.isPassword == true);
    setState(() {
      isObsure = widget.isPassword == true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        onChanged: (value) {
          print(value);
        },
        obscureText: isObsure,
        controller: widget.controller,
        keyboardType: widget.inputType,
        decoration: InputDecoration(
          suffixIcon: widget.isPassword
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      isObsure = !isObsure;
                    });
                    // if(isObsure==true){
                    //   isObsure=false;
                    // }else{
                    //   isObsure=true;
                    // }
                  },
                  child: Icon(
                    isObsure ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black,
                  ))
              : SizedBox(),
          // hintText:name,
          hintText: widget.hintTxt,
          enabledBorder: OutlineInputBorder(),
          border: OutlineInputBorder(),
          errorBorder: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(),
          disabledBorder: OutlineInputBorder(),
          focusedErrorBorder: OutlineInputBorder(),
        ),
      ),
    );
  }
}
