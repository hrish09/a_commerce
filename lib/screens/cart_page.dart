import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/custom_widgets/top_bar.dart';
import 'package:e_commerce/screens/product_page.dart';
import 'package:e_commerce/services/firebase_services.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  FirebaseServices firebaseServices = FirebaseServices();
  int numberOfProducts = 0;
  int totalSum = 0;

  Future<int> getNumberOfProducts() {
    return firebaseServices.userReference
        .doc(firebaseServices.getUserID())
        .collection('Cart')
        .snapshots()
        .length;
  }

  Future getTotalSum() async {
    dynamic sum = 0;
    await firebaseServices.userReference
        .doc(firebaseServices.getUserID())
        .collection('Cart')
        .get()
        .then((ds) {
      ds.docs.forEach((product) {
        sum = sum + product.data()['price'];
      });
    });
    totalSum = sum;
  }

  Future removeProduct(String productId) {
    return firebaseServices.userReference
        .doc(firebaseServices.getUserID())
        .collection("Cart")
        .doc('$productId')
        .delete();
  }

  @override
  void initState() {
    getTotalSum();
    setState(() {
    });
    print(totalSum);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getTotalSum();

    int sum=totalSum;
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
                  .collection('Cart')
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
                  return ListView(
                      padding: EdgeInsets.only(
                        top: 116,
                        bottom: 79,
                      ),
                      children: snapshot.data!.docs.map(
                        (document) {
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
                                if (productSnap.hasError) {
                                  return Scaffold(
                                    body: Center(
                                      child:
                                          Text("Error : ${productSnap.error}"),
                                    ),
                                  );
                                }
                                ;

                                if (productSnap.connectionState ==
                                    ConnectionState.done) {
                                  Map productMap = productSnap.data!.data();
                                  // Map prices=productMap['price'];
                                  // totalPrice=prices.values.reduce((sum, element) => sum + element);

                                  return Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        new BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 8,
                                        )
                                      ],
                                      color: Color(0xFF246EE9).withOpacity(0.3),
                                    ),
                                    height: 110,
                                    margin: EdgeInsets.only(
                                      left: 12,
                                      top: 24,
                                      right: 12,
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                                "${productMap["images"][1]}"),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 18,
                                          ),
                                          child: Expanded(
                                            child: Container(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${productMap["name"]}',
                                                    overflow: TextOverflow.fade,
                                                    maxLines: 1,
                                                    softWrap: false,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Rs. ${productMap["price"]}',
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Size : ${document.data()["size"]}',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            width: double.infinity,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(right: 24),
                                          child: GestureDetector(
                                            onTap: () async {
                                              await removeProduct(document.id);
                                              await getTotalSum();
                                              setState(() {});
                                            },
                                            child: Icon(
                                              Icons.delete_rounded,
                                              color: Colors.white,
                                              size: 28,
                                            ),
                                          ),
                                        ),
                                      ],
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
                        },
                      ).toList());
                }

                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
            TopBar(
              isBack: true,
              title: "Cart",
              isGradientVisible: true,
              hastitle: true,
              colour: Colors.white,
              colour2: Colors.white.withOpacity(0),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Colors.purple.shade700, Color(0xFF246EE9)]),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset.zero,
                        blurRadius: 20,
                        spreadRadius: 0.03,
                      ),
                    ]),
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      Text(
                        'Rs. ${sum}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
