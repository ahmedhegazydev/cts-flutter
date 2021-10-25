import 'package:cts/constants/routes.dart';
import 'package:cts/presentation/screens/document_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cts/presentation/screens/Landing_page.dart';
import '../screens/Login_page.dart';

class AppRoutes {
  Route? generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case LoginPageRoute:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case LandingPageRoute:
        return MaterialPageRoute(builder: (_) => LandingPage());
      case DocumentPageRoute:
        return MaterialPageRoute(builder: (_) => DocumentPage());
    }
  }
}
