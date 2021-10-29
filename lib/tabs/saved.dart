import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/custom_widgets/top_bar.dart';
import 'package:e_commerce/screens/product_page.dart';
import 'package:e_commerce/services/firebase_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class Saved extends StatelessWidget {
  final String heading;
  final String? actionBarTitle;
  final bool? backButton;
  final bool? hasTitle;

  Saved(
      {required this.heading,
      this.actionBarTitle,
      this.backButton,
      this.hasTitle});

  FirebaseServices firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [Colors.pink.shade700, Colors.deepPurple],
          ),
        ),
        child: Stack(
          children: [
            FutureBuilder<QuerySnapshot>(
              future: firebaseServices.userReference
                  .doc(firebaseServices.getUserID())
                  .collection("Saved")
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error : ${snapshot.error}"),
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 100,
                      left: 12,
                      right: 12,
                    ),
                    child: ListView(
                        children: snapshot.data!.docs.map((document) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductPage(
                                        productID: document.id,
                                      )));
                        },
                        child: FutureBuilder<DocumentSnapshot>(
                          future: firebaseServices.productReference
                              .doc(document.id)
                              .get(),
                          builder: (context, productSnap) {
                            if (snapshot.hasError) {
                              return Scaffold(
                                body: Center(
                                  child: Text("Error : ${snapshot.error}"),
                                ),
                              );
                            }

                            if (productSnap.connectionState ==
                                ConnectionState.done) {
                              Map productMap = productSnap.data!.data();

                              return Container(
                                height: 175,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    new BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 8,
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xFF246EE9).withOpacity(0.3),
                                ),
                                margin: EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                                child: Expanded(
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Image.network(
                                            "${productMap["images"][1]}"),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(left: 8),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${productMap["name"]}',
                                                overflow: TextOverflow.fade,
                                                maxLines: 1,
                                                softWrap: false,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                '${productMap["description"]}',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white70,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                softWrap: false,
                                              ),
                                              Text(
                                                'Rs. ${productMap["price"]}',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                            ;
                            return Scaffold(
                              body: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                        ),
                      );
                    }).toList()),
                  );
                }
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
            TopBar(
              isBack: backButton,
              title: actionBarTitle,
              hastitle: hasTitle,
            ),
          ],
        ),
      ),
    );
  }
}
