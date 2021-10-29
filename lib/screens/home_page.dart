import 'package:e_commerce/constants.dart';
import 'package:e_commerce/tabs/home.dart';
import 'package:e_commerce/tabs/saved.dart';
import 'package:e_commerce/tabs/search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/custom_widgets/bottom_tabs.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tabPage = 0;
  late PageController tabsPageController;

  @override
  void initState() {
    tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: PageView(
              controller: tabsPageController,
              onPageChanged: (num) {
                setState(() {
                  tabPage = num;
                });
              },
              children: [
                Home(heading: 'Home Page',actionBarTitle: 'Home',backButton: false,hasTitle: true,),
                Search(),
                Saved(heading: 'Saved Page',actionBarTitle: 'Saved Products',backButton: false,hasTitle: true,),
              ],
            )),
            Container(
                child: BottomTabs(
              bottomSelectedTab: tabPage,
              tapCallback: (num) {
                tabsPageController.animateToPage(
                  num,
                  duration: Duration(microseconds: 300),
                  curve: Curves.easeInOutCubic,
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
