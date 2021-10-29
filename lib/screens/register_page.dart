import 'package:e_commerce/constants.dart';
import 'package:e_commerce/custom_widgets/custom_button.dart';
import 'package:e_commerce/custom_widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {



  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String enteredText = "";

  String userEmail=" ";
  String password="";

  Future<String?> registerUser() async{
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: userEmail, password: password);
      return null;
    }on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    }catch(e){
      return e.toString();
    }
  }

  void submitForm() async {
    String? submitFormFeedback=await registerUser();
    if(submitFormFeedback==null){
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  child: Text(
                    'Create a new account',
                    style: Constants.heading,
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextField(
                    obsecure: false,
                    hintText: 'Email...',
                    onChnaged: (value) {
                      userEmail = value;
                    },
                  ),
                  CustomTextField(
                    obsecure: true,
                    hintText: 'Password...',
                    onChnaged: (value) {
                      password = value;
                    },
                  ),
                  Container(
                    width: 350,
                    padding: EdgeInsets.only(bottom: 10),
                    child: CustomButton(
                      onTapped: (){
                        submitForm();
                      },
                      change: true,
                      buttonText: 'Create account',
                    ),
                  ),
                ],
              ),
              Container(
                width: 350,
                padding: EdgeInsets.only(bottom: 10),
                child: CustomButton(
                  change: false,
                  onTapped: (){
                      Navigator.pop(context);
                  },
                  buttonText: 'Back to login',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
