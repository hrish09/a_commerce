import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/screens/cart_page.dart';
import 'package:e_commerce/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TopBar extends StatefulWidget {
  final bool? isBack;
  final String? title;
  final bool? hastitle;
  final Color? colour;
  final Color? colour2;
  final bool? isGradientVisible;

  TopBar(
      {required this.isBack,
      required this.title,
      this.hastitle,
      this.isGradientVisible,
      this.colour,
      this.colour2});

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {

  FirebaseServices firebaseServices=FirebaseServices();
  final CollectionReference userRef =
      FirebaseFirestore.instance.collection("Users");
  User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    bool back = widget.isBack ?? false;
    bool isGradient = widget.isGradientVisible ?? true;

    return Container(
      decoration: BoxDecoration(
        gradient: isGradient
            ? LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.purple.shade700, Color(0xFF246EE9)])
            : null,
          boxShadow: [
            BoxShadow(
              offset: Offset.zero,
              blurRadius: 20,
              spreadRadius: 0.03,
            )
          ]),
      padding: EdgeInsets.only(
        top: 56,
        left: 24,
        right: 24,
        bottom: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (back)
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              height: 42,
              width: 42,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image(
                  image: AssetImage('assets/images/back_arrow.png'),
                  color: Theme.of(context).accentColor,
                  height: 20,
                  width: 20,
                ),
              ),
            ),
          if (widget.hastitle == true)
            Text(
              widget.title ?? 'Action Bar',
              style: Constants.heading,
            ),
          Container(
            alignment: Alignment.center,
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            child: StreamBuilder<QuerySnapshot>(
              stream: userRef.doc(user.uid).collection("Cart").snapshots(),
              builder: (context, snapshot) {
                int totalItems = 0;
                List documents = snapshot.data!.docs;
                totalItems = documents.length;

                return GestureDetector(
                  onTap: () {
                    print(documents.length);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CartPage()));
                  },
                  child: Image(
                    image: AssetImage('assets/images/cart_icon.png'),
                    height: 20,
                    width: 20,
                    color: totalItems > 0
                        ? Theme.of(context).accentColor
                        : Colors.white,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// LinearGradient(
// colors: [
// widget.colour ?? Colors.white,
// widget.colour2 ?? Colors.white.withOpacity(0),
// ],
// begin: Alignment(0, 0),
// end: Alignment(0, 1),
// )