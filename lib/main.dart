import 'package:flutter/material.dart';
import 'package:sih_pipeline_project/pages/login_page.dart';
import 'package:sih_pipeline_project/pages/main_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'SIH Pipe-Management-App',
      home: MyLoginPage(),
      routes: {
        '/mainpage': (context) => const MainPage(),
      },
    );
  }
}
