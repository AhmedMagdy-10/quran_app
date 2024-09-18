import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:quran/quran.dart';
import 'package:quran_app/constant/colors.dart';
import 'package:quran_app/core/helper/build_verse_spans.dart';
import 'package:quran_app/features/quranDetails/ui/widgets/custom_ayaa_option_feature.dart';
import 'package:quran_app/features/quranDetails/ui/widgets/share_ayaa_as_image.dart';
import 'package:quran_app/features/quranDetails/ui/widgets/share_ayaa_as_text.dart';
import 'package:quran_app/generated/l10n.dart';

Future<dynamic> showBottomSheetAyaaFeature(
  BuildContext context, {
  required int index,
  var surahNumber,
  var verseNumber,
}) async {
  int firstVerse = verseNumber;
  int lastVerse = verseNumber;

  return showMaterialModalBottomSheet(
    enableDrag: true,
    expand: false,
    duration: const Duration(milliseconds: 500),
    backgroundColor: Colors.white,
    context: context,
    animationCurve: Curves.easeInOutQuart,
    elevation: 0,
    bounce: true,
    builder: (context) {
      return SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: secondColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "${S.of(context).surah}${getSurahNameArabic(surahNumber)}: ($verseNumber)",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20.sp,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      const Divider(),
                      SizedBox(
                        height: 10.w,
                      ),
                      InkWell(
                        onTap: () {
                          sharedAyaaOption(context,
                              index: index,
                              surahNumber: surahNumber,
                              verseNumber: verseNumber);
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: RichText(
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,
                                textWidthBasis: TextWidthBasis.longestLine,
                                locale: const Locale("ar"),
                                text: TextSpan(
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  children: buildVerseSpans(surahNumber,
                                      firstVerse, lastVerse, verseNumber, null),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.w,
                            ),
                            Icon(
                              Icons.share_rounded,
                              color: threeColor,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.w,
              ),
              const CustomAyaaOptionFeature(
                icon: Icons.bookmark_add_rounded,
                text: "اضافة كعلامة مرجعيه",
              ),
              SizedBox(
                height: 10.w,
              ),
              const CustomAyaaOptionFeature(
                icon: Icons.menu_book_sharp,
                text: "التفسير",
              ),
              SizedBox(
                height: 10.w,
              ),
              const CustomAyaaOptionFeature(
                icon: Icons.settings_voice_rounded,
                text: "القارئ",
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<Object?> sharedAyaaOption(
  BuildContext context, {
  required int index,
  surahNumber,
  verseNumber,
}) {
  int firstVerse = verseNumber;
  int lastVerse = verseNumber;
  return showGeneralDialog(
    context: context,
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Container();
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
        child: FadeTransition(
          opacity: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
          child: StatefulBuilder(
            builder: (context, setState) {
              return CupertinoAlertDialog(
                title: Text(
                  'قال تعالي :',
                  style: TextStyle(
                    color: fiveColor,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      textWidthBasis: TextWidthBasis.longestLine,
                      locale: const Locale("ar"),
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        children: buildVerseSpans(surahNumber, firstVerse,
                            lastVerse, verseNumber, null),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "[${getSurahNameArabic(surahNumber)}: $firstVerse - $lastVerse]",
                      style: TextStyle(
                        color: fiveColor,
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(
                      height: 5.w,
                    ),
                  ],
                ),
                actions: <Widget>[
                  ShareAyaaAsText(
                    firstVerse: firstVerse,
                    lastVerse: lastVerse,
                    surahNumber: surahNumber,
                    verseNumber: verseNumber,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShareAyaaAsImagepPage(
                            firstVerse: firstVerse,
                            lastVerse: lastVerse,
                            surahNumber: surahNumber,
                            verseNumber: verseNumber,
                            pageNumber: index,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'مشاركه كصوره',
                      style: TextStyle(
                        color: fiveColor,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    },
  );
}
