import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/quran.dart';
import 'package:quran_app/constant/colors.dart';
import 'package:quran_app/core/helper/skeletoizer_loading.dart';
import 'package:quran_app/features/quranList/logic/cubits/quran_cubit.dart';
import 'package:quran_app/features/quranList/logic/cubits/quran_states.dart';
import 'package:quran_app/features/quranList/ui/widgets/ayaat_list_title.dart';
import 'package:quran_app/core/components/custom_text_field.dart';

class QuranPage extends StatelessWidget {
  const QuranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuranPageCubit>(
      create: (context) => QuranPageCubit()..getAllAyaat(),
      child: BlocBuilder<QuranPageCubit, QuranPageStates>(
        builder: (context, state) {
          var allAyaat = context.read<QuranPageCubit>().allAyaat;
          var ayaatSrearched = context.read<QuranPageCubit>().ayaatSrearched;
          var ayaatFiltered = context.read<QuranPageCubit>().ayatFiltered;
          // var searchValue;
          return Scaffold(
            appBar: AppBar(
              scrolledUnderElevation: 0,
              title: const Text('القران الكريم'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 20,
                  ),
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
                      state is LoadingQuranState
                          ? SkeletoinzerLoading(
                              enabled: true,
                              list: getDummyList(),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) => Divider(
                                    color: secondColor,
                                  ),
                              itemBuilder: (context, index) {
                                final ayah = ayaatSrearched[index];
                                return AyaatListTitle(ayah: ayah);
                              },
                              itemCount: ayaatSrearched.length),
                      if (ayaatFiltered != null)
                        ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final ayaa = ayaatFiltered["result"][index];
                            return CustomAyaatFiltered(ayaa: ayaa);
                          },
                          separatorBuilder: (context, index) => const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Divider(),
                          ),
                          itemCount: ayaatFiltered['occurences'] > 15
                              ? 15
                              : ayaatFiltered['occurences'],
                        )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CustomAyaatFiltered extends StatelessWidget {
  const CustomAyaatFiltered({
    super.key,
    required this.ayaa,
  });

  final dynamic ayaa;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: secondColor,
          boxShadow: [
            BoxShadow(
              color: threeColor,
              blurRadius: 5,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Column(
          children: [
            Text(
              " سورة ${getSurahNameArabic(
                ayaa['surah'],
              )}",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: kprimaryDarkColor),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(getVerse(ayaa['surah'], ayaa['verse'], verseEndSymbol: true),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 17,
                    )),
          ],
        ),
      ),
    );
  }
}
