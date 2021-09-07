import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/presentation/screens/Landing.dart';
import 'package:test_app/constants/globals.dart';
import '../screens/Login.dart';

class AppRoutes {
  Route? generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case LandingPageRoute:
        return MaterialPageRoute(builder: (_) => LandingPage());
      case LoginPageRoute:
        return MaterialPageRoute(builder: (_) => LoginPage());
    }
  }
}
