import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/core/helper/show_toast_state.dart';
import 'package:quran_app/cubits/main_cubit.dart';
import 'package:quran_app/cubits/main_cubit_states.dart';
import 'package:quran_app/widgets/ayaat_list_title.dart';

class QuranPage extends StatelessWidget {
  const QuranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainCubitStates>(listener: (context, state) {
      if (state is LoadingMainState) {
        const Center(child: CircularProgressIndicator());
      } else if (state is ErrorMainState) {
        return showToast(text: state.errorMessage, state: ToastStates.error);
      }
    }, builder: (context, state) {
      final ayaat = context.read<MainCubit>().ayaat;

      return Scaffold(
          appBar: AppBar(
            title: const Text('القران الكريم'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                color: Colors.grey,
              ),
              itemBuilder: (context, index) {
                final ayah = ayaat[index];
                return AyaatListTitle(ayah: ayah);
              },
              itemCount: ayaat.length,
            ),
          ));
    });
  }
}
