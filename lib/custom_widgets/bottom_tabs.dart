import 'package:e_commerce/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BottomTabs extends StatefulWidget {
  int bottomSelectedTab;
  Function(int) tapCallback;

  BottomTabs({required this.bottomSelectedTab, required this.tapCallback});

  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.purple.shade700, Color(0xFF246EE9)]),
          // borderRadius: BorderRadius.only(
          //     topRight: Radius.circular(10), topLeft: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              offset: Offset.zero,
              blurRadius: 20,
              spreadRadius: 0.03,
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Tabs(
            img_path: 'assets/images/tab_home.png',
            selected: widget.bottomSelectedTab == 0 ? true : false,
            onPressed: () {
              widget.tapCallback(0);
            },
          ),
          Tabs(
            img_path: 'assets/images/tab_search.png',
            selected: widget.bottomSelectedTab == 1 ? true : false,
            onPressed: () {
              widget.tapCallback(1);
            },
          ),
          Tabs(
            img_path: 'assets/images/tab_saved.png',
            selected: widget.bottomSelectedTab == 2 ? true : false,
            onPressed: () {
              widget.tapCallback(2);
            },
          ),
          GestureDetector(
            child: Tabs(
              img_path: 'assets/images/tab_logout.png',
              selected: widget.bottomSelectedTab == 3 ? true : false,
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Tabs extends StatelessWidget {
  Tabs(
      {required this.img_path,
      required this.selected,
      required this.onPressed});

  final String img_path;
  final bool selected;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    String path = img_path;
    bool tapped = selected;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
          color: tapped ? Theme.of(context).accentColor : Colors.transparent,
          width: 2.5,
        ))),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Image(
          height: 28,
          width: 28,
          color: tapped ? Theme.of(context).accentColor : Colors.black,
          image: AssetImage(path),
        ),
      ),
    );
  }
}
