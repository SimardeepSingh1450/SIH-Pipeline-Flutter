import 'package:flutter/material.dart';
import 'package:sih_pipeline_project/pages/login_page.dart';
import 'package:sih_pipeline_project/pages/main_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:sih_pipeline_project/progress.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('progressBox');
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
