import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../utility/all_const.dart';
import '../utility/storage.dart';

class  MController extends GetxController{

  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  Color appcolor=AppColor;
  setAppColor(Color color){
    appcolor=color;

    update();
  }

  @override
  void onInit() {
    super.onInit();
  int? a= SecureStorage().readAppColor();
     if(a!=null){
       setAppColor(Color(a));
     }else{
       setAppColor(AppColor);
     }
  }
}