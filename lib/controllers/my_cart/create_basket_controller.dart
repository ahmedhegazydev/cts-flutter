import 'dart:convert';

import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../utility/validator.dart';

class CreateBasketController extends GetxController {
  TextEditingController englishName = TextEditingController();
  TextEditingController arabicName = TextEditingController();
  Validators validators = Validators();
  final createBasketFormKey = GlobalKey<FormState>();
  bool islogin = false;
  Color pickerColor = Colors.transparent;

  setPickerColor(Color newColor){
    print(newColor);
    pickerColor =  newColor;
    update();
  }


}
