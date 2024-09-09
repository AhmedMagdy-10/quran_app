import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/constant/colors.dart';
import 'package:quran_app/core/helper/cache_helper.dart';
import 'package:quran_app/features/splash/ui/splash_page.dart';
import 'package:quran_app/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  bool? mode = CacheHelper.getSaveData(key: 'isDark');
  runApp(MyApp(
    mode: mode,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.mode});
  final bool? mode;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 813),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: const Locale('ar'),
        debugShowCheckedModeBanner: false,
        theme: lightTheme(context),
        darkTheme: darkTheme(context),
        themeMode: mode == null
            ? ThemeMode.system
            : mode!
                ? ThemeMode.dark
                : ThemeMode.light,
        home: const SplashView(),
      ),
    );
  }
}
