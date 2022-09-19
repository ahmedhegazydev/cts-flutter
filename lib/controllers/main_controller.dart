import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utility/all_const.dart';
import '../utility/storage.dart';

class MController extends GetxController {
  Color pickerColor = Color(0x0d2b40);
  Color currentColor = Color(0x0d2b40);
  Color appcolor = AppColor;
  bool changeColorImmediately = false;

  setAppColor(Color color) {
    appcolor = color;
    update();
  }

  setChangeColorImmediately(bool changeColorImmediately) {
    this.changeColorImmediately = changeColorImmediately;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    int? a = SecureStorage().readAppColor();
    if (a != null) {
      setAppColor(Color(a));
    } else {
      setAppColor(AppColor);
    }
  }
}
