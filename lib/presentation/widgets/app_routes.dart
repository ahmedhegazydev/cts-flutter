import 'package:cts/constants/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cts/presentation/screens/Landing.dart';
import '../screens/Login.dart';

class AppRoutes {
  Route? generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case LoginPageRoute:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case LandingPageRoute:
        return MaterialPageRoute(builder: (_) => LandingPage());
    }
  }
}
