import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../utility/all_string_const.dart';
import '../utility/storage.dart';

class AuthMiddleWare extends GetMiddleware {
  final SecureStorage _secureStorage = SecureStorage();

  @override
  RouteSettings? redirect(String? route) {
    print(_secureStorage.readSecureData(AllStringConst.Token));
    if (_secureStorage.readSecureData(AllStringConst.Token) == null) {

   print(   _secureStorage.readSecureData(AllStringConst.Token));
      return RouteSettings(name: "/LoginPage");
     // return const RouteSettings(name: "/InboxPage");
      // return const RouteSettings(name: "/Filter");
    }else{
      print(   "/Landing");
      return   RouteSettings(name: "/Landing");
    }

  }
}
