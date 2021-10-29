import 'package:e_commerce/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {


  String buttonText="Click here";
  void Function() onTapped;
  bool change=false;
  CustomButton({required this.buttonText,required this.onTapped,required this.change});


  @override
  Widget build(BuildContext context) {
    bool onChange=change;
    return GestureDetector(
      onTap: onTapped,
      child: Container(
        margin: EdgeInsets.only(top:10),
        height: 50,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: onChange ? Colors.black : Colors.white,
          border: Border.all(color: Colors.black,width: 3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(buttonText,style: onChange ?  Constants.buttonText : TextStyle(color: Colors.black),),
      ),
    );
  }
}
