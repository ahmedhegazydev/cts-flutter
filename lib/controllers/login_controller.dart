import 'dart:convert';

import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../services/apis/log_api.dart';
import '../services/json_model/login_model.dart';
import '../utility/all_string_const.dart';
import '../utility/storage.dart';
import '../utility/validator.dart';
import 'landing_page_controller.dart';

class LoginController extends GetxController {
  TextEditingController userName = TextEditingController();
  TextEditingController baseUrl = TextEditingController(
      text: 'http://192.168.1.6:9091/Mobility/CMS.svc'
      // text: 'http://139.99.149.12:9091/EverSuite.CTS.Mobile/CMS.svc'
      );
  BuildContext? context;
  TextEditingController passWord = TextEditingController();
  Validators validators = Validators();
  final loginFormKey = GlobalKey<FormState>();
  bool islogin = false;
  SecureStorage secureStorage = SecureStorage();

  clear(){
    baseUrl.clear();
    update();
  }
  logIngRequst(
 //  { required context}
  ) {
    if (loginFormKey.currentState!.validate()) {
      islogin = true;
      update();
      userLogin(context: context!);
    }
  }

  faceIdButtonOnClick() {}

  String encryptPassword(String password) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    final key = enc.Key.fromBase64(stringToBase64.encode("xxxYYYxxxZZZxxxE"));
    final iv = enc.IV.fromLength(16);
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));
    final encrypted = encrypter.encrypt(password, iv: iv);
    return encrypted.base64;
  }

  userLogin(
  { required context}
  ) async {
    LogInApi logInApi = LogInApi(context!);
    var encryptedPassword = encryptPassword(passWord.text);
    //language=${defaultLocale == "en" ? "en" : "ar"}
    print("pass word            :    $encryptedPassword");
    logInApi.loginData =
        'userCode=${userName.text}&password=$encryptedPassword&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}&includeIcons=true';

    try {
      await logInApi.getData(
         // context: context
      ).then((value) async {
        if (value != null) {
          LoginModel loginModel = value as LoginModel;
          loginModel.inbox?.inboxItems?.forEach((element) {
            // print(element?.total);
            print("0000000000000000000000000000000000000000000000000000000");
            print(element.name);
            print(element.inboxId);
            print("0000000000000000000000000000000000000000000000000000000");
          });
          secureStorage.writeSecureData(
              AllStringConst.Token, loginModel.token!);
          await secureStorage.writeSecureJsonData(
              AllStringConst.LogInData, loginModel.toJson());
          print("oooooooooooooooooo  ${loginModel.customActions?[0].name}");
          //    print("signature  ${loginModel}");
          print(
              "loginModel.tokenloginModel.tokenloginModel.token      ${loginModel.token}");
            secureStorage.writeSecureData(
              AllStringConst.Token, loginModel.token!);
            secureStorage.writeSecureData(
              AllStringConst.UserId, loginModel.userId);
            secureStorage.writeSecureData(
              AllStringConst.FirstName, loginModel.firstName);
         secureStorage.writeSecureData(
              AllStringConst.LastName, loginModel.lastName);
          await secureStorage.writeSecureData(
              AllStringConst.DepartmentName, loginModel.departmentName);
          await secureStorage.writeSecureData(
              AllStringConst.Pincode, loginModel.pincode);
          await secureStorage.writeSecureData(
              AllStringConst.Signature, loginModel.signature);
          await secureStorage.writeSecureData(
              AllStringConst.SignatureId, loginModel.signatureId);
          await secureStorage.writeSecureData(
              AllStringConst.UserDetails, loginModel.userDetails);
          await secureStorage.writeSecureData(
              AllStringConst.ServiceType, loginModel.serviceType);


          Get.put(  LandingPageController());


          Get.offNamed("/Landing");
        }
      }).catchError((err){
        islogin = false;
        update();

      });
      islogin = false;
      update();
    } catch (error) {
      islogin = false;
      update();
      print(error.toString());
    }
  }
}
