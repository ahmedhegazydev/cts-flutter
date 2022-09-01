import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../utility/all_string_const.dart';
import '../utility/storage.dart';

class AuthMiddleWare extends GetMiddleware {
    SecureStorage _secureStorage = SecureStorage();

  @override
  RouteSettings? redirect(String? route) {
bool log=_secureStorage.readBoolData(AllStringConst.Token);
    if (log )
      return   RouteSettings(name: "/Landing");

    else
      return RouteSettings(name: "/LoginPage");



  }
}
