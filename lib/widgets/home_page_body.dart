import 'package:flutter/material.dart';
import 'package:quran_app/constant/colors.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: quranPagesColorLight,
        title: Text(
          'الرئسيه',
          textDirection: TextDirection.rtl,
          style: TextStyle(
            color: kprimaryColor,
            fontSize: 18,
          ),
        ),
      ),
      body: Container(),
    );
  }
}
