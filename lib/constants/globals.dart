import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Globals {
  static final url = "http://192.168.20.237:89/Eversuite.CTS.Mobile/CMS.svc/";
  static final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  static TextEditingController userNameController = new TextEditingController();
  static TextEditingController passwordController = new TextEditingController();
}
