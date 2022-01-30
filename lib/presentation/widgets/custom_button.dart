import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final double width;
  final Color backGroundColor;
  final Color titleColor;
  final String title;
  final FontWeight fontWeight;
  final double fontSize;
  CustomButton(
      {this.height = 50,this.fontSize=14,
      required this.width,
      required this.backGroundColor,
      required this.title,
      required this.titleColor,
      this.fontWeight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backGroundColor,
          borderRadius: BorderRadius.all(Radius.circular(6))),
      height: height,
      width: width,
      child: Center(
          child: Text(
        title,
        style: TextStyle(fontWeight: fontWeight, color: titleColor,fontSize: fontSize),

      )),
    );
  }
}
