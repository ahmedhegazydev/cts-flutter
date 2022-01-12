import 'dart:convert';
import 'package:cts/caching/app_cache.dart';
import 'package:cts/constants/globals.dart';
import 'package:cts/constants/my_custom_navigator.dart';
import 'package:cts/constants/routes.dart';
import 'package:cts/data/models/LoginModel.dart';
import 'package:cts/presentation/components/loading_indicator.dart';
import 'package:cts/services/http.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

class LoginController extends GetxController {



     authenticate() async {
      // bool didAuthenticate = await LocalAuthentication().authenticate(
      //     localizedReason: 'Please authenticate to Login', biometricOnly: true);
      // if (didAuthenticate) {
      //   loginButtonPressed();
      // }
    }
    String getCurrentYearString() {
     // initializeDateFormatting();
      DateTime now = DateTime.now();
      var formatter = DateFormat("yyyy", "en");
      String date = formatter.format(now);
      return date;
    }

  LoginModel loginModel = new LoginModel();
  Http http = new Http();
  String encryptPassword(String password) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    final key = enc.Key.fromBase64(stringToBase64.encode("xxxYYYxxxZZZxxxE"));
    final iv = enc.IV.fromLength(16);
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));
    final encrypted = encrypter.encrypt(password, iv: iv);
    return encrypted.base64;
  }

  Future<LoginModel> userLogin(String userName, String password) async {
    var encryptedPassword = encryptPassword(password);
    var defaultLocale = ui.window.locale.languageCode;
    try {
      var response = await http.getRequest(Globals.url +
          'Login?userCode=$userName&password=$encryptedPassword&language=${defaultLocale == "en" ? "en" : "ar"}&includeIcons=true');
      var data = jsonDecode(response.body);
      loginModel = LoginModel.fromJson(data);
      if (loginModel.userId != null) {
        hideLoadingIndicator();
       // Globals.navigatorKey.currentState?.pushNamed(LandingPageRoute);
       // MyCustomNavigator.CustomPushName(context: context, pagename: pagename)
        Get.toNamed(Routes.LoginPageRoute);
      }
      AppCache.saveUserToken(loginModel.token!);
      AppCache.saveUserSignature(loginModel.signature!);
      return loginModel;
    } catch (error) {
      // Globals.snackbarKey.currentState?.showSnackBar(Globals.returnSnackBarText(
      //   AppLocalizations.of(Globals.navigatorKey.currentContext!)!
      //       .tryAgainLater,
      // ));
      hideLoadingIndicator();
    }
    //notifyListeners();
    return loginModel;
  }
}
