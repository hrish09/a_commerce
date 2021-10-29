import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/screens/product_page.dart';
import 'package:e_commerce/services/firebase_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  FirebaseServices firebaseServices = FirebaseServices();
  String productName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [Colors.pink.shade700, Colors.deepPurple],
          ),
        ),
        // margin: const EdgeInsets.only(
        //   top: 30,
        //   left: 24,
        //   right: 24,
        // ),
        child: Stack(
          children: [
            if (productName.isEmpty)
              Center(
                child: Container(
                  child: Text(
                    'Search Results',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            // if (!productName.isEmpty)

            if (!productName.isEmpty)
              FutureBuilder<QuerySnapshot>(
                future: firebaseServices.productReference
                    .orderBy('searcher')
                    .startAt([productName]).endAt(["$productName\uf8ff"]).get(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Scaffold(
                      body: Center(
                        child: Text("Error : ${snapshot.error}"),
                      ),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    List foundItems = snapshot.data!.docs;
                    print(foundItems.length);
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 96,
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
                                          builder: (context) =>
                                              ProductPage(
                                                productID: document.id,
                                              )));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.white70),
                                    ),
                                  ),
                                  height: 60,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.search,
                                        color: Colors.white70,
                                      ),
                                      Image.network(
                                          '${document.data()['images'][0]}'),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 12,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${document.data()['name']}',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Icon(
                                                Icons.call_missed_outgoing,
                                                color: Colors.white70,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
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
            Padding(
              padding: const EdgeInsets.only(
                top: 40,
                left: 12,
                right: 12,
              ),
              child: Container(
                height: 62,
                child: TextField(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  onChanged: (name) {
                    setState(() {
                      productName = name.toLowerCase();
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search here...',
                    hintStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                    filled: true,
                    fillColor: Colors.black26,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    suffixIcon: Icon(
                      Icons.search,
                      color: Theme
                          .of(context)
                          .accentColor,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                        color: Theme
                            .of(context)
                            .accentColor,
                        width: 2.5,
                      ),
                    ),
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
