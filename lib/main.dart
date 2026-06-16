import 'package:flutter/material.dart';
import 'package:htql_app/presentation/provider/bottomnavigation_provider.dart';
import 'package:htql_app/presentation/router/app_router.dart';
import 'package:provider/provider.dart';

void main() {
  // /// instance test
  // /// instance test1
  // final test1 = TestClass(name: 'Flutter');

  // /// instance test2
  // final test2 = TestClass(name: 'Flutter');
  // print(test2 == test1); // should print false
  // print('\n');
  // print(identical(test1, test2)); // should print false
  // WidgetsFlutterBinding.ensureInitialized();

  /// initialize StorageService singleton
  // await StorageService.instance.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers:   [
      ChangeNotifierProvider(create: (_) => BottomnavigationProvider()),
    ], child: const MyAppbody());
  }
}


class MyAppbody extends StatelessWidget {
  const MyAppbody({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: AppRouter.loginScreen,
      routes: AppRouter().routes,
    );
  }
}

