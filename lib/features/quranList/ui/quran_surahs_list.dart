import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:quran/quran.dart';
import 'package:quran_app/constant/colors.dart';
import 'package:quran_app/core/helper/hive_helper.dart';
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
          var cubit = context.read<QuranPageCubit>();
          bool isSearched = cubit.searchQuery;

          var allAyaat = cubit.allAyaat;
          var ayaatSrearched = cubit.ayaatSrearched;
          var ayaatFiltered = cubit.ayatFiltered;

          int lastRead = getHiveSavedData('lastRead');
          int totalVerses = 604;

          double progress = lastRead / totalVerses;

// If lastRead is equal to totalVerses, set the progress to 1.0 (i.e., 100%)
          if (lastRead >= totalVerses) {
            progress = 1.0;
          }
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
                    if (getHiveSavedData('lastRead') != "non" &&
                        (isSearched == false))
                      InkWell(
                        onTap: () {
                          print(getVerseCount(
                              getPageData(getHiveSavedData('lastRead'))[0]
                                  ['surah']));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SurahDetailsPage(
                                  pageNumber: getHiveSavedData('lastRead'),
                                  jsonData: allAyaat,
                                  highlightVerse: "",
                                  shouldHighlightText: false,
                                  shouldHighlightSura: false,
                                ),
                              ));
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 20.h),
                          child: Container(
                              padding: EdgeInsets.all(8.w),
                              width: MediaQuery.sizeOf(context).width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.r),
                                color: specialGreen,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 8.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "اخر ما تم قراءته",
                                          style: TextStyle(
                                            color: kprimaryColor,
                                            fontSize: 20.sp,
                                            fontFamily: 'taha',
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15.h,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              getSurahNameArabic(getPageData(
                                                  getHiveSavedData(
                                                      'lastRead'))[0]['surah']),
                                              style: TextStyle(
                                                color: kprimaryColor,
                                                fontSize: 30.sp,
                                                fontFamily: 'taha',
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Text(
                                              "(ص : ${getHiveSavedData('lastRead')})",
                                              style: TextStyle(
                                                color: kprimaryColor,
                                                fontSize: 20.sp,
                                                fontFamily: 'taha',
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        CircularPercentIndicator(
                                          backgroundColor: Colors.white,
                                          animation: true,
                                          radius: 23,
                                          lineWidth: 5,
                                          percent: progress,
                                          center: Text(
                                              '${(progress * 100).toStringAsFixed(1)}%',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15.sp,
                                              )),
                                          progressColor: Colors.blue,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/image/lastRead.png',
                                    fit: BoxFit.cover,
                                    width: 100.w,
                                    height: 100.h,
                                  ),
                                  // const Icon(
                                  //   Icons.arrow_forward_ios_outlined,
                                  //   color: Colors.white,
                                  // )
                                ],
                              )),
                        ),
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
                            separatorBuilder: (context, index) => const Divider(
                                  color: Colors.grey,
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
                                          jsonData: allAyaat,
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
