import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  String hintText='';
  Function(String text)? onChnaged;
  bool obsecure=false;
  CustomTextField({required this.hintText,this.onChnaged,required this.obsecure});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 25),
      child: TextField(
        onChanged: onChnaged,
        obscureText: obsecure,
        decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: Colors.black12,
          filled: true,
          hintText: hintText,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black,width: 1.5),
          ),
          // hintStyle: TextStyle(
          //   color: Colors.black12,
          // ),
        ),
      ),
    );
  }
}
