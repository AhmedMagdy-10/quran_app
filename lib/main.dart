import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/constant/colors.dart';
import 'package:quran_app/core/helper/cache_helper.dart';
import 'package:quran_app/cubits/main_cubit.dart';
import 'package:quran_app/cubits/main_cubit_states.dart';
import 'package:quran_app/views/splash_page.dart';

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
    return BlocProvider<MainCubit>(
      create: (context) => MainCubit(),
      child: BlocBuilder<MainCubit, MainCubitStates>(builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme(context),
          darkTheme: darkTheme(context),
          themeMode: mode == null
              ? ThemeMode.system
              : BlocProvider.of<MainCubit>(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
          home: const SplashView(),
        );
      }),
    );
  }
}
