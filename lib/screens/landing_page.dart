import 'package:e_commerce/constants.dart';
import 'package:e_commerce/screens/home_page.dart';
import 'package:e_commerce/screens/login.dart';
import 'package:e_commerce/screens/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("Error : ${snapshot.error}"),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, streamSnapshot) {
                if(streamSnapshot.hasError){
                  return Scaffold(
                    body: Center(
                      child: Text(
                        "Error: ${streamSnapshot.error}"
                      ),
                    ),
                  );
                };

                if(streamSnapshot.connectionState==ConnectionState.active){ //ConnectionState.active so as to check if logged in user is active
                  User? _user = streamSnapshot.data as User?;
                  if(_user==null){
                    return Login();
                  }else{
                    return HomePage();
                  }
                }
                //checking the loading state...
                return Scaffold(
                  body: Center(
                    child: Text(
                      "Checking Authentication.....",
                      style: Constants.regularHeading,
                    ),
                  ),
                );

              },
            );
          }

          return Scaffold(
            body: Center(
              child: Text(
                "Firebase app initialising....",
                style: Constants.regularHeading,
              ),
            ),
          );
        });
  }
}
