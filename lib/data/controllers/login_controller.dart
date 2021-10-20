import 'dart:convert';
import 'package:cts/constants/globals.dart';
import 'package:cts/constants/routes.dart';
import 'package:cts/data/models/LoginModel.dart';
import 'package:cts/presentation/components/loading_indicator.dart';
import 'package:cts/services/http.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
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
    try {
      var response = await http.getRequest(Globals.url +
          'Login?userCode=$userName&password=$encryptedPassword&language=ar&includeIcons=true');
      var data = jsonDecode(response.body);
      loginModel = LoginModel.fromJson(data);
      notifyListeners();
      if (loginModel.userId != null) {
        hideLoadingIndicator();
        Globals.navigatorKey.currentState?.pushNamed(LandingPageRoute);
      }
      return loginModel;
    } catch (error) {
      hideLoadingIndicator();
      Exception(error);
    }
    hideLoadingIndicator();
    notifyListeners();
    return loginModel;
  }
}
