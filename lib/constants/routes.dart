import 'package:cts/presentation/screens/Landing_page.dart';
import 'package:cts/presentation/screens/Login_page.dart';
import 'package:cts/presentation/screens/document_page.dart';
import 'package:flutter/material.dart';



class MyRouter{
  static Route<dynamic>myGenerateRoute(RouteSettings settings){
    switch(settings.name){
      case Routes.DocumentPageRoute:
        return MaterialPageRoute(builder: (context)=>  DocumentPage() );
      case Routes.LoginPageRoute:
        return MaterialPageRoute(builder: (context)=>  LoginPage( ));
      case Routes.LandingPageRoute:
        return MaterialPageRoute(builder: (context)=>  LandingPage( ));
      default:
            return MaterialPageRoute(builder: (context)=>  LandingPage( ));
    }
  }
}


class Routes{
  static const LoginPageRoute = '/LoginPage';
  static const LandingPageRoute = '/LandingPage';
  static const DocumentPageRoute = '/DocumentPage';

}