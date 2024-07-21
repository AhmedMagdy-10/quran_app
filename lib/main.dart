import 'package:flutter/material.dart';
import 'package:quran_app/constant/colors.dart';
import 'package:quran_app/views/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kprimaryColor,
      ),
      home: const SplashView(),
    );
  }
}
