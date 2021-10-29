import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SizeTab extends StatefulWidget {
  final List sizes;
  final Map<String, dynamic> documentData;
  final Function(String size) sizeOpted;

  SizeTab({required this.sizes, required this.documentData,required this.sizeOpted});

  @override
  _SizeTabState createState() => _SizeTabState();
}

class _SizeTabState extends State<SizeTab> {
  int selectedSizeTab = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < widget.sizes.length; i++)
          GestureDetector(
            onTap: () {
              widget.sizeOpted('${widget.documentData['size'][i]}');
              setState(() {
                selectedSizeTab = i;
              });
            },
            child: Container(
              margin: EdgeInsets.only(left: 16, top: 0),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: selectedSizeTab==i ? Theme.of(context).accentColor : Color(0xFFDCDCDC),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  '${widget.documentData['size'][i]}',
                  style: TextStyle(
                    fontSize: selectedSizeTab==i ? 20 : 16,
                    fontWeight: selectedSizeTab==i ? FontWeight.w700 : null,
                    color: selectedSizeTab==i ? Colors.white : null,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
