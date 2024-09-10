import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/quran.dart';
import 'package:quran_app/constant/colors.dart';
import 'package:quran_app/core/helper/skeletoizer_loading.dart';
import 'package:quran_app/features/quranDetails/ui/surah_details_page.dart';
import 'package:quran_app/features/quranList/logic/cubits/quran_cubit.dart';
import 'package:quran_app/features/quranList/logic/cubits/quran_states.dart';
import 'package:quran_app/features/quranList/ui/widgets/ayaat_list_title.dart';
import 'package:quran_app/core/components/custom_text_field.dart';
import 'package:quran_app/features/quranList/ui/widgets/custom_ayaat%20_filtered.dart';
import 'package:quran_app/generated/l10n.dart';

class QuranSurahPage extends StatelessWidget {
  const QuranSurahPage({super.key});

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
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 16.h,
                  horizontal: 20.w,
                ),
                child: Column(
                  children: [
                    CustomTextField(
                      onChanged: (value) {
                        context.read<QuranPageCubit>().searchAyaat(value);
                      },
                      hintText: S.of(context).searchBySurah,
                    ),
                    SizedBox(
                      height: 20.h,
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
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SurahDetailsPage(
                                          pageNumber:
                                              getPageNumber(ayah.number, 1),
                                          jsonData: ayaatSrearched,
                                          highlightVerse: "",
                                          shouldHighlightText: false,
                                          shouldHighlightSura: false,
                                        ),
                                      ),
                                    );
                                  },
                                  child: AyaatListTitle(ayah: ayah));
                            },
                            itemCount: ayaatSrearched.length),
                    if (ayaatFiltered != null)
                      ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final ayaa = ayaatFiltered["result"][index];
                          return CustomAyaatFiltered(
                            ayaa: ayaa,
                            onTap: () {
                              final surah = ayaa['surah'];
                              final verse = ayaa['verse'];
                              final highlightVerse =
                                  getVerse(surah, verse, verseEndSymbol: true);
                              final pageNumber = getPageNumber(surah, verse);

                              print(
                                  "Navigating to page: $pageNumber with highlightVerse: $highlightVerse");

                              print(highlightVerse);
                              print(pageNumber);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SurahDetailsPage(
                                    pageNumber: pageNumber,
                                    jsonData: allAyaat,
                                    shouldHighlightText: true,
                                    highlightVerse: highlightVerse,
                                    shouldHighlightSura: true,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        separatorBuilder: (context, index) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: const Divider(),
                        ),
                        itemCount: ayaatFiltered['occurences'] > 10
                            ? 10
                            : ayaatFiltered['occurences'],
                      )
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
