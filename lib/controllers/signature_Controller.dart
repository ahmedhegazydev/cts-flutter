import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

import '../services/json_model/login_model.dart';
import '../utility/all_string_const.dart';
import '../utility/storage.dart';
class SignaturePageController extends GetxController{
  Map <String,dynamic>?logindata;
  List<MultiSignatures> multiSignatures=[];
  final SecureStorage secureStorage = SecureStorage();



  final SignatureController controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );











  @override
  void onReady() {
    super.onReady();




    logindata=secureStorage.readSecureJsonData(AllStringConst.LogInData) ;
    if(logindata!=null){
      LoginModel data=LoginModel.fromJson(logindata!);
    multiSignatures=  data.multiSignatures??[];
update();
    }


  }
}