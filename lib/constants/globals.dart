import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Globals {
  static final url = "http://192.168.20.237:89/Eversuite.CTS.Mobile/CMS.svc/";
  static final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  static TextEditingController userNameController = new TextEditingController();
  static TextEditingController passwordController = new TextEditingController();
  static int inboxIdForCorrespondencesList = 0;
  static final GlobalKey<ScaffoldMessengerState> snackbarKey =
      GlobalKey<ScaffoldMessengerState>();

  static returnSnackBarText(String text) {
    final SnackBar snackBar = SnackBar(
      dismissDirection: DismissDirection.vertical,
      content: Text(
        text,
        style: TextStyle(
          fontSize: 19,
          fontFamily: "Bahij",
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.red[700],
    );
    return snackBar;
  }
}
