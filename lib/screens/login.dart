import 'package:e_commerce/constants.dart';
import 'package:e_commerce/custom_widgets/custom_button.dart';
import 'package:e_commerce/custom_widgets/custom_textfield.dart';
import 'package:e_commerce/screens/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {


  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String userEmail = "";
  String password = "";

  Future<String?> signIn() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: userEmail, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
      return e.message;
    }catch(e){
      return e.toString();
    }
  }

  void submitForm() async {
    String? submitFormFeedback=await signIn();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Text("Log In Your Account",style: Constants.heading,),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextField(
                  hintText: 'Enter registered email',
                  onChnaged: (value) {
                    userEmail = value;
                  },
                  obsecure: false,
                ),
                CustomTextField(
                  hintText: 'Enter your password',
                  onChnaged: (value) {
                    password = value;
                  },
                  obsecure: true,
                ),
                Container(
                  width: 350,
                  padding: EdgeInsets.only(bottom: 10),
                  child: CustomButton(
                    buttonText: "LogIn",
                    onTapped: () {
                      submitForm();
                    },
                    change: true,
                  ),
                ),
              ],
            ),
            Container(
              width: 350,
              padding: EdgeInsets.only(bottom: 10),
              child: CustomButton(
                buttonText: "Create Account",
                onTapped: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterPage()));
                },
                change: false,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
