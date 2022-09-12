
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../utility/validator.dart';

class CreateBasketController extends GetxController {
  TextEditingController englishName = TextEditingController();
  TextEditingController arabicName = TextEditingController();
  Validators validators = Validators();
  final createBasketFormKey = GlobalKey<FormState>();
  bool islogin = false;

  Color pickerColor = Colors.white;
  // Color pickerColor = Colors.black;

  TextEditingController textEditingControllerEnglishName=TextEditingController();
  TextEditingController textEditingControllerArabicName=TextEditingController();

  setPickerColor(Color newColor){
    print(newColor);
    pickerColor =  newColor;
    update();
  }

  createNewBasket() {
    // getSerchData = true;
    // update();
    // String rf = "";
  }


}

