import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/cubits/main_cubit.dart';
import 'package:quran_app/cubits/main_cubit_states.dart';

import 'package:quran_app/widgets/home_page_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainCubitStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                scrolledUnderElevation: 0,
                elevation: 0,
                title: Text(
                  'الرئيسية',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        BlocProvider.of<MainCubit>(context).changeAppMode();
                      },
                      icon: BlocProvider.of<MainCubit>(context).isDark
                          ? const Icon(
                              Icons.sunny,
                              color: Colors.amber,
                            )
                          : const Icon(
                              Icons.brightness_2,
                              color: Colors.blueAccent,
                            ))
                ],
              ),
              body: const HomePageBody(),
            ),
          );
        });
  }
}
