import 'package:flutter/material.dart';

class MyCustomNavigator {
  static CustomPushName({required context, required String pagename}) {
    Navigator.pushNamed(context, pagename);
  }

  static CustomPushReplacementName({required context, required String pagename}) {
    Navigator.pushReplacementNamed(context, pagename);
  }

  static CustomPushNameAndRemoveUntil({required context, required String pagename}) {
    Navigator.pushNamedAndRemoveUntil(context, pagename, (route) => false);
  }

  static MyPop({required context }) {
    Navigator.of(context).pop();
  }
  static MyMayBePop({required context }) {
    Navigator.of(context).maybePop();
  }
  static MypopUntil({required context , required String pagename}) {
    Navigator.of(context).popUntil(ModalRoute.withName(pagename));
  }
}
