import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ImageSwipe extends StatefulWidget {
  final List? imageList;

  ImageSwipe({this.imageList});

  @override
  _ImageSwipeState createState() => _ImageSwipeState();
}

class _ImageSwipeState extends State<ImageSwipe> {
  int swipe = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0xFF246EE9).withOpacity(0.3),
          ),
          height: 400,
          child: PageView(
            onPageChanged: (num) {
              setState(() {
                swipe = num;
              });
            },
            children: [
              for (var i = 0; i < widget.imageList!.length; i++)
                Container(
                  child: Image.network('${widget.imageList![i]}'),
                ),
            ],
          ),
        ),
        Positioned(
          bottom: 18,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < widget.imageList!.length; i++)
                AnimatedContainer(
                  curve: Curves.easeOutCubic,
                  duration: Duration(microseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  height: 10,
                  width: (swipe == i) ? 35 : 10,
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                )
            ],
          ),
        )
      ],
    );
  }
}

/*

Positioned(
bottom: 18,
left: 0,
right: 0,
child: Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Container(
margin: EdgeInsets.symmetric(horizontal: 5),
height: 12,
width: 12,
decoration: BoxDecoration(
color: Theme.of(context).accentColor,
borderRadius: BorderRadius.circular(12),
),
),
Container(
margin: EdgeInsets.symmetric(horizontal: 5),
height: 12,
width: 12,
decoration: BoxDecoration(
color: Theme.of(context).accentColor,
borderRadius: BorderRadius.circular(12),
),),
Container(
margin: EdgeInsets.symmetric(horizontal: 5),
height: 12,
width: 12,
decoration: BoxDecoration(
color: Theme.of(context).accentColor,
borderRadius: BorderRadius.circular(12),
),),
],
),
) */
