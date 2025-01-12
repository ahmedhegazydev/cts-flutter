import 'dart:convert';

import 'package:cts/db/cts_database.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../services/apis/log_api.dart';
import '../services/json_model/login_model.dart';
import '../utility/all_string_const.dart';
import '../utility/storage.dart';
import '../utility/utilitie.dart';
import '../utility/validator.dart';
import 'landing_page_controller.dart';

class LoginController extends GetxController {
  TextEditingController userName = TextEditingController();
  TextEditingController baseUrl = TextEditingController(
      // text: 'http://ecm-mob.mofa.gov.qa:9091/Eversuite.CTS.Mobile2/CMS.svc',
      text: 'http://139.99.149.12:9091/EverSuite.CTS.Mobile/CMS.svc');
  BuildContext? context;
  TextEditingController passWord = TextEditingController();
  Validators validators = Validators();
  final loginFormKey = GlobalKey<FormState>();
  bool islogin = false;
  DateTime time = DateTime.now();

  checkTokenTimeStamp() {
    DateTime time = DateTime.now();
    List? resList =
        SecureStorage.to.getTokenWithTimeStamp("userToken", "createdTime");

    if (resList == null || resList[1] == null || resList[0] == null) return;
    DateTime parseDate =
        new DateFormat("yyyy-MM-dd hh:mm:ss").parse(resList[1]);
    if ((time.hour - parseDate.hour) < 1) {
      SecureStorage.to.writeSecureData(AllStringConst.Token, resList[0]);
      Get.put(LandingPageController());
      Get.offNamed("/Landing");
    } else {}
  }

  @override
  void onReady() {
    super.onReady();
    //checkTokenTimeStamp();
  }

  clear() {
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

  userLogin({required context}) async {
    LogInApi logInApi = LogInApi(context!);
    var encryptedPassword = encryptPassword(passWord.text);
    //language=${defaultLocale == "en" ? "en" : "ar"}
    print("pass word            :    $encryptedPassword");
    logInApi.loginData =
        'userCode=${userName.text}&password=$encryptedPassword&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}&includeIcons=true';

    try {
      showLoaderDialog(context!);
      await logInApi
          .getData(
              // context: context
              )
          .then((value) async {
        if (value != null) {
          LoginModel loginModel = value as LoginModel;
          loginModel.inbox?.inboxItems?.forEach((element) {
            // print(element?.total);
            print("0000000000000000000000000000000000000000000000000000000");
            print(element.name);
            print(element.inboxId);
            print("0000000000000000000000000000000000000000000000000000000");
          });
          SecureStorage.to
              .writeSecureData(AllStringConst.Token, loginModel.token!);
          await SecureStorage.to.writeSecureJsonData(
              AllStringConst.LogInData, loginModel.toJson());
          print("oooooooooooooooooo  ${loginModel.customActions?[0].name}");
          //    print("signature  ${loginModel}");
          print(
              "loginModel.tokenloginModel.tokenloginModel.token      ${loginModel.token}");
          await SecureStorage.to.saveTokenWithTimeStamp(
              "userToken", loginModel.token!, "createdTime", time.toString());
          await SecureStorage.to
              .writeSecureData(AllStringConst.Token, loginModel.token!);
          await SecureStorage.to
              .writeSecureData(AllStringConst.UserId, loginModel.userId);
          await SecureStorage.to
              .writeSecureData(AllStringConst.FirstName, loginModel.firstName);
          await SecureStorage.to
              .writeSecureData(AllStringConst.LastName, loginModel.lastName);
          await SecureStorage.to.writeSecureData(
              AllStringConst.DepartmentName, loginModel.departmentName);
          await SecureStorage.to
              .writeSecureData(AllStringConst.Pincode, loginModel.pincode);
          //  await SecureStorage.to.deleteSecureData(AllStringConst.Signature);
          await SecureStorage.to.writeSecureData(
              AllStringConst.Signature, loginModel.signature ?? "");

          await SecureStorage.to.writeSecureData(
              AllStringConst.SignatureId, loginModel.signatureId);
          await SecureStorage.to.writeSecureData(
              AllStringConst.UserDetails, loginModel.userDetails);
          await SecureStorage.to.writeSecureData(
              AllStringConst.ServiceType, loginModel.serviceType);

          Get.put(LandingPageController());

          Get.offNamed("/Landing");
        } else {
          // Get.snackbar("Error".tr, "WrongUsername".tr);
          Navigator.pop(context!);
        }
      }).catchError((err) {
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
