import 'package:boilerplate/presentation/home/home.dart';
import 'package:boilerplate/presentation/login/login.dart';
import 'package:boilerplate/ui_kit/examples/ui_kit_example_screen.dart';
import 'package:boilerplate/features/auth/presentation/pages/register_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/post';
  static const String uiKitExample = '/ui-kit-example';
  static const String register = '/register';

  static final routes = <String, WidgetBuilder>{
    login: (BuildContext context) => LoginScreen(),
    register: (BuildContext context) => RegisterScreen(),
    home: (BuildContext context) => HomeScreen(),
    uiKitExample: (BuildContext context) => UIKitExampleScreen(),
  };
}
