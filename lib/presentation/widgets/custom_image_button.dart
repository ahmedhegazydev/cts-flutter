import 'package:flutter/material.dart';

class CustomImageButton extends StatelessWidget {
  final double height;
  final double width;
  final Color backGroundColor;
final String pic;

  CustomImageButton({this.height=50,required this.width,required this.backGroundColor,required this.pic});

  @override
  Widget build(BuildContext context) {
    return Container(height:height ,width: width,decoration: BoxDecoration(color: backGroundColor,
        borderRadius: BorderRadius.all(Radius.circular(6))),
      child: FractionallySizedBox(heightFactor: .8, widthFactor: .8,
        child: Image.asset(pic),
      ),
    );
  }
}
