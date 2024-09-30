import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:quran_app/constant/colors.dart';
import 'package:quran_app/core/components/custom_app_bar.dart';
import 'package:quran_app/features/home/logic/cubits/main_cubit.dart';
import 'package:quran_app/features/home/logic/cubits/main_cubit_states.dart';

import 'package:quran_app/features/home/ui/widgets/home_page_body.dart';
import 'package:quran_app/generated/l10n.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainCubit>(
      create: (context) => MainCubit(),
      child: BlocConsumer<MainCubit, MainCubitStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: CustomAppBar(
                title: Text(
                  S.of(context).homeTitle,
                ),
                actions: [
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: fiveColor,
                            width: 0.5,
                          ),
                        ),
                        child: Icon(
                          Iconsax.notification_bing_outline,
                          color: fiveColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              body: const HomePageBody(),
            );
          }),
    );
  }
}
