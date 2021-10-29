import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/custom_widgets/image_swipe.dart';
import 'package:e_commerce/custom_widgets/size_tabs.dart';
import 'package:e_commerce/custom_widgets/top_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/services/firebase_services.dart';

class ProductPage extends StatefulWidget {
  final String? productID;

  ProductPage({this.productID});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FirebaseServices firebaseServices = FirebaseServices();

  String selectedSize = 'S';

  String msg = "";



  Future addToCart(int price) {
    return firebaseServices.userReference
        .doc(firebaseServices.getUserID())
        .collection("Cart")
        .doc(widget.productID)
        .set({"size": selectedSize,"price":price});
  }

  Future save() {
    return firebaseServices.userReference
        .doc(firebaseServices.getUserID())
        .collection("Saved")
        .doc(widget.productID)
        .set({'size': selectedSize});
  }

  final SnackBar snackBarOfCart = SnackBar(
    content: Text("Item added to cart"),
  );

  final SnackBar snackBarOfSave = SnackBar(
    content: Text("Item saved"),
  );

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
            FutureBuilder<DocumentSnapshot>(
                future:
                    firebaseServices.productReference.doc(widget.productID).get(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Scaffold(
                      body: Center(
                        child: Text(
                          "Error : ${snapshot.error}",
                        ),
                      ),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> documentData =
                        snapshot.data!.data() as Map<String, dynamic>;

                    //For getting the length of image array
                    List imageList = documentData['images'];
                    List size = documentData['size'];
                    return ListView(
                      padding: EdgeInsets.all(0),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 98,
                          ),
                          child: SafeArea(
                            child: ImageSwipe(
                              imageList: imageList,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            left: 16,
                            right: 16,
                            bottom: 4,
                          ),
                          child: Text(
                            '${documentData['name']}',
                            style: Constants.regularHeading,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 16,
                          ),
                          child: Text(
                            'Rs. ${documentData['price']}',
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 16,
                          ),
                          child: Text(
                            '${documentData['description']} ',
                            style: TextStyle(fontSize: 16, color: Colors.white70),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                            top: 16,
                            bottom: 12,
                          ),
                          child: Text(
                            'Select Size',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizeTab(
                          sizes: size,
                          documentData: documentData,
                          sizeOpted: (size) {
                            selectedSize = size;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 40,
                            bottom: 16,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 12,
                              right: 12,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    await save();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBarOfSave);
                                  },
                                  child: Container(
                                    height: 65,
                                    width: 66,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFDCDCDC),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    margin: EdgeInsets.only(
                                      left: 16,
                                    ),
                                    child: Center(
                                        child: Image.asset(
                                            'assets/images/tab_saved.png')),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      await addToCart(documentData['price']);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBarOfCart);
                                    },
                                    child: Container(
                                      width: 240,
                                      height: 65,
                                      margin: EdgeInsets.only(left: 16),
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'ADD TO CART',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  return Scaffold(
                    body: Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                }),
            TopBar(
              isBack: true,
              title: 'Product',
              hastitle: false,
              isGradientVisible: true,
            ),
            Container()
          ],
        ),
      ),
    );
  }
}
