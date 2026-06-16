import 'package:flutter/material.dart';
import 'package:htql_app/presentation/UI/bottomnav/bottomnav.dart';
import 'package:htql_app/presentation/UI/docs/docs_screen.dart';
import 'package:htql_app/presentation/UI/event/event_sreen.dart';
import 'package:htql_app/presentation/UI/leave/leave_screen.dart';
import 'package:htql_app/presentation/UI/login/login_screen.dart';
import 'package:htql_app/presentation/UI/home/home_screen.dart';

class AppRouter {
  //
  static const String loginScreen = '/loginscreen';
  static const String homeScreen = '/homescreen';
  static const String docsScreen = '/docsscreen';
  static const String eventScreen = '/eventscreen';
  static const String leaveScreen = '/leavescreen';
  static const String bottomNav = '/bottomnav';

  Map<String, Widget Function(BuildContext context)> routes =
      <String, WidgetBuilder>{
        AppRouter.loginScreen: (context) => const LoginScreen(),
        AppRouter.homeScreen: (context) => const HomeScreen(),
        AppRouter.leaveScreen: (context) => const LeaveScreen(),
        AppRouter.eventScreen: (context) => const EventSreen(),
        AppRouter.docsScreen: (context) => const DocsScreen(),
        AppRouter.bottomNav: (context) => const BottomNav(),
      };
}
