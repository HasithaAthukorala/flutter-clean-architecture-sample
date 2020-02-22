import 'package:flutter/material.dart';
import 'package:clean_architecture_with_bloc_app/screens/change_password/presentation/page/change_password.dart';
import 'package:clean_architecture_with_bloc_app/screens/home/presentation/page/home.dart';
import 'package:clean_architecture_with_bloc_app/screens/login/presentation/page/login.dart';
import 'constants.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LOGIN_ROUTE:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case HOME_ROUTE:
        return MaterialPageRoute(builder: (_) => HomePage());
      case CHANGE_PASSWORD_ROUTE:
        return MaterialPageRoute(builder: (_) => ChangePasswordPage());
      default:
        return MaterialPageRoute(builder: (_) => LoginPage());
    }
  }
}
