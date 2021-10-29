import 'dart:math';
import 'package:e_commerce/custom_widgets/top_bar.dart';
import 'package:e_commerce/screens/product_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/services/firebase_services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Home extends StatelessWidget {
  FirebaseServices firebaseServices = FirebaseServices();

  final String heading;
  final String? actionBarTitle;
  final bool? backButton;
  final bool? hasTitle;

  Home(
      {required this.heading,
      this.actionBarTitle,
      this.backButton,
      this.hasTitle});

  List<StaggeredTile> generateRandomTiles(int count) {
    Random rnd = new Random();
    List<StaggeredTile> _staggeredTiles = [];
    for (int i = 0; i < count; i++) {
      num mainAxisCellCount = 0;
      double temp = rnd.nextDouble();

      if (temp > 0.6) {
        mainAxisCellCount = temp + 0.5;
      } else if (temp < 0.3) {
        mainAxisCellCount = temp + 0.9;
      } else {
        mainAxisCellCount = temp + 0.7;
      }
      _staggeredTiles.add(new StaggeredTile.count(
          rnd.nextInt(1) + 1, mainAxisCellCount.toDouble()));
    }
    return _staggeredTiles;
  }

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
              future: firebaseServices.productReference.get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error : ${snapshot.error}"),
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  List listProductImage = snapshot.data!.docs
                      .map((e) => '${e.data()['images'][1]}')
                      .toList();
                  List listProductName = snapshot.data!.docs
                      .map((e) => '${e.data()['name']}')
                      .toList();
                  List productId =
                      snapshot.data!.docs.map((e) => '${e.id}').toList();
                  return StaggeredGridView.countBuilder(
                    crossAxisCount: 8,
                    padding: EdgeInsets.only(
                      top: 128,
                      bottom: 4,
                      left: 12,
                      right: 12,
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductPage(
                                      productID: productId[index],
                                    )));
                      },
                      child: Card(
                        color: Color(0xFF246EE9).withOpacity(0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 5,
                        child: Expanded(
                          child: Stack(
                            children: [
                              Center(
                                child: Image(
                                    image: Image.network(listProductImage[index])
                                        .image),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Center(
                                    child: Text(
                                  '${listProductName[index]}',
                                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),

                                )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    staggeredTileBuilder: (int index) =>
                        new StaggeredTile.count(4, index.isEven ? 4 : 7),
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 6.0,
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

// StaggeredGridView.count(crossAxisCount: 2
// ,
// children: snapshot.data!.
// docs.map((
// document) {
// return GestureDetector(
// onTap: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => ProductPage(
// productID: document.id,
// )));
// },
// child: Container(
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(12),
// ),
// height: 350,
// margin: EdgeInsets.symmetric(
// vertical: 12,
// horizontal: 24,
// ),
// child: Stack(
// children: [
// Container(
// child: Image.network(
// "${document.data()['images'][1]}",
// fit: BoxFit.cover,
// ),
// ),
// Positioned(
// bottom: 0,
// left: 0,
// right: 0,
// child: Padding(
// padding: const EdgeInsets.symmetric(
// vertical: 8,
// horizontal: 10,
// ),
// child: Row(
// mainAxisAlignment:
// MainAxisAlignment.spaceBetween,
// children: [
// Text(
// '${document.data()['name']}',
// style: Constants.regularHeading,
// ),
// Text(
// 'Rs.${document.data()['price']}',
// style: TextStyle(
// fontSize: 17,
// fontWeight: FontWeight.w600,
// color: Theme.of(context).accentColor,
// ),
// ),
// ],
// ),
// ),
// )
// ],
// ),
// ),
// );
// })
// .
// toList
// (
// ),staggeredTiles: generateRandomTiles
// (
// snapshot.data!.
// docs.length),
// );
