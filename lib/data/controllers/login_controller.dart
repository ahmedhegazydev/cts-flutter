import 'dart:convert';
import 'package:cts/constants/globals.dart';
import 'package:cts/data/models/LoginModel.dart';
import 'package:cts/services/http.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';

//final getLoginData = ChangeNotifierProvider<Login>((ref) => Login());

class Login extends ChangeNotifier {
  Http http = new Http();

  Future userLogin(
      BuildContext context, String userName, String encryptedPassword) async {
    Locale appLocale = Localizations.localeOf(context);
    try {
      var response = await http.get(
        Globals.url +
            'Login?userCode=$userName&password=$encryptedPassword&language=${appLocale.languageCode == "en" ? "en" : "ar"}&includeIcons=true',
      );
      // Map resContent = json.decode(response.body);
      // var model = LoginModel.fromJson(resContent);
      return LoginModel.fromJson(jsonDecode(response.body));
    } catch (error) {
      Exception(error);
    }
  }
}
