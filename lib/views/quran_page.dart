import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/cubits/quran_page_cubit.dart/quran_cubit.dart';
import 'package:quran_app/cubits/quran_page_cubit.dart/quran_states.dart';
import 'package:quran_app/widgets/ayaat_list_title.dart';
import 'package:quran_app/widgets/custom_text_field.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({super.key});

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuranPageCubit>(
      create: (context) => QuranPageCubit()..getAllAyaat(),
      child: BlocBuilder<QuranPageCubit, QuranPageStates>(
        builder: (context, state) {
          var ayaat = context.read<QuranPageCubit>().ayaat;
          // var searchValue;
          return Scaffold(
            appBar: AppBar(
              scrolledUnderElevation: 0,
              title: const Text('القران الكريم'),
              centerTitle: true,
            ),
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    CustomTextField(
                      onChanged: (value) {
                        context.read<QuranPageCubit>().searchAyaat(value);
                      },
                      hintText: " البحث بسورة او الايه او الصفحة",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (context, index) => const Divider(
                          color: Colors.grey,
                        ),
                        itemBuilder: (context, index) {
                          final ayah = ayaat[index];
                          return AyaatListTitle(ayah: ayah);
                        },
                        itemCount: ayaat.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
