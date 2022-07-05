import 'package:flutter/material.dart';

class SignatureInfo{
  Size? size;
  Offset? offset;
  String? signature;

  SignatureInfo({required this.size,required this.offset,required this.signature});



  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();








    return data;
  }
}