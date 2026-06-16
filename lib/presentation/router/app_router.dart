import 'package:flutter/material.dart';
import 'package:htql_app/presentation/UI/login/login_screen.dart';

class AppRouter {
  //
  static const String loginScreen = '/loginscreen';



  Map<String, Widget Function(BuildContext context)> routes =
      <String, WidgetBuilder>{
        AppRouter.loginScreen: (context) => const LoginScreen(),
      };
}
