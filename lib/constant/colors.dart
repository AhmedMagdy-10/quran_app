import 'package:flutter/material.dart';
import 'package:quran_app/constant/style.dart';

Color quranPagesColorLight = const Color(0xffF1EEE5);
Color quranPagesColorDark = const Color(0xff292C31);
Color kprimaryColor = const Color(0xfffffaf5);
Color secondColor = const Color(0xfffceddc);
Color threeColor = const Color(0xff966e3c);
Color fourColor = const Color(0xff795547);
Color kprimaryDarkColor = const Color(0xfffeab1f);
Color secondDarkColor = const Color(0xfff8480d);

ThemeData lightTheme(BuildContext context) => ThemeData(
      // fontFamily: 'Cairo',
      scaffoldBackgroundColor: kprimaryColor,
      appBarTheme: AppBarTheme(
        backgroundColor: kprimaryColor,
        titleTextStyle: TextStyle(
          color: fourColor,
          fontSize: responsiveFontSize(context, fontSize: 32),
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: TextTheme(
        titleMedium: TextStyle(
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w300,
          fontSize: responsiveFontSize(context, fontSize: 20),
          color: threeColor,
        ),
        titleLarge: TextStyle(
          color: fourColor,
          fontSize: responsiveFontSize(context, fontSize: 32),
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          fontSize: 28,
          color: threeColor,
          fontFamily: 'Cairo',
        ),
      ),
    );

ThemeData darkTheme(BuildContext context) => ThemeData(
      scaffoldBackgroundColor: quranPagesColorDark,
      appBarTheme: AppBarTheme(
        backgroundColor: quranPagesColorDark,
        titleTextStyle: TextStyle(
          color: fourColor,
          fontSize: responsiveFontSize(context, fontSize: 32),
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: TextTheme(
        titleMedium: TextStyle(
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w300,
          fontSize: responsiveFontSize(
            context,
            fontSize: 20,
          ),
          color: kprimaryDarkColor,
        ),
        titleLarge: TextStyle(
          color: kprimaryDarkColor,
          fontSize: responsiveFontSize(context, fontSize: 32),
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: const TextStyle(
          fontSize: 28,
          fontFamily: 'Cairo',
          color: Color.fromARGB(255, 235, 152, 27),
        ),
      ),
    );
