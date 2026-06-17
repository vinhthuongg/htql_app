import 'package:flutter/material.dart';
import 'package:htql_app/presentation/provider/attendance_provider.dart';
import 'package:htql_app/presentation/provider/auth_provider.dart';
import 'package:htql_app/presentation/provider/bottomnavigation_provider.dart';
import 'package:htql_app/presentation/provider/docs_provider.dart';
import 'package:htql_app/presentation/provider/leave_provider.dart';
import 'package:htql_app/presentation/provider/reward_provider.dart';
import 'package:htql_app/presentation/provider/theme_provider.dart';
import 'package:htql_app/presentation/router/app_router.dart';
import 'package:htql_app/presentation/theme/app_color.dart';
import 'package:htql_app/services/storage_service.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // /// instance test
  // /// instance test1
  // final test1 = TestClass(name: 'Flutter');

  // /// instance test2
  // final test2 = TestClass(name: 'Flutter');
  // print(test2 == test1); // should print false
  // print('\n');
  // print(identical(test1, test2)); // should print false
  // WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.instance.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AttendanceProvider()),
        ChangeNotifierProvider(create: (_) => BottomnavigationProvider()),
        ChangeNotifierProvider(create: (_) => DocsProvider()),
        ChangeNotifierProvider(create: (_) => LeaveProvider()),
        ChangeNotifierProvider(create: (_) => RewardProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyAppbody(),
    );
  }
}

class MyAppbody extends StatelessWidget {
  const MyAppbody({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final initialRoute = StorageService.instance.getAuthAccessToken().isNotEmpty
        ? AppRouter.bottomNav
        : AppRouter.loginScreen;

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          themeMode: themeProvider.themeMode,
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: AppColor.background,
            colorScheme: ColorScheme.fromSeed(seedColor: AppColor.toyotaRed),
            appBarTheme: AppBarTheme(
              backgroundColor: AppColor.background,
              foregroundColor: AppColor.black,
              elevation: 0,
              surfaceTintColor: AppColor.background,
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: AppColor.black,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColor.toyotaRed,
              brightness: Brightness.dark,
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: AppColor.black,
              foregroundColor: AppColor.white,
              elevation: 0,
              surfaceTintColor: AppColor.black,
            ),
          ),
          initialRoute: initialRoute,
          routes: AppRouter().routes,
        );
      },
    );
  }
}
