import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../utility/all_string_const.dart';
import '../utility/storage.dart';

class AuthMiddleWare extends GetMiddleware {
  final SecureStorage _secureStorage = SecureStorage();

  @override
  RouteSettings? redirect(String? route) {
    print(_secureStorage.readSecureData(AllStringConst.Token));
    if (_secureStorage.readSecureData(AllStringConst.Token) != null) {
      return const RouteSettings(name: "/Landing");
      // return const RouteSettings(name: "/Filter");
    }
  }
}
