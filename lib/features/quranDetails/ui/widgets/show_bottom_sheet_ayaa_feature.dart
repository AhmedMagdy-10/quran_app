import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:quran/quran.dart';

import 'package:quran_app/constant/colors.dart';
import 'package:quran_app/core/helper/hive_helper.dart';
import 'package:quran_app/core/helper/remove_html_tags.dart';
import 'package:quran_app/features/quranDetails/logic/translation/get_translation_data.dart'
    as translation;
import 'package:quran_app/features/quranDetails/logic/translation/translationdata.dart';
import 'package:quran_app/features/quranDetails/ui/widgets/custom_ayaa_option_feature.dart';
import 'package:quran_app/generated/l10n.dart';
import 'package:share_plus/share_plus.dart';

List<InlineSpan> buildVerseSpans(
    int surahNumber, int firstVerseNumber, int lastVerseNumber, verseNumber) {
  List<InlineSpan> verseSpans = [];

  String verseText = getVerseQCF(surahNumber, verseNumber);
  if (verseNumber == firstVerseNumber) {
    verseText.replaceFirst(" ", "\n");
    verseText =
        "${verseText.substring(0, 2)}${verseText.substring(2, verseText.length)}";
  }

  int pageNumber = getPageNumber(surahNumber, verseNumber);
  // print("QCF_P${pageNumber.toString().padLeft(3, "0")}");
  TextSpan verseSpan = TextSpan(
    text: verseText.replaceAll(' ', ''),
    // recognizer: LongPressGestureRecognizer()..onLongPress = () {},
    style: TextStyle(
      color: Colors.black,
      overflow: TextOverflow.ellipsis,
      fontSize: 21.sp,
      wordSpacing: 0,
      letterSpacing: 0,
      fontFamily: "QCF_P${pageNumber.toString().padLeft(3, "0")}",
    ),
  );

  verseSpans.add(verseSpan);
  return verseSpans;
}

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
                                  children: buildVerseSpans(surahNumber,
                                      firstVerse, lastVerse, verseNumber),
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
          child: CupertinoAlertDialog(
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
                    children: buildVerseSpans(
                        surahNumber, firstVerse, lastVerse, verseNumber),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "[ ${getSurahNameArabic(surahNumber)} : $verseNumber ]",
                  style: TextStyle(
                    color: fiveColor,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  print(getHiveSavedData("addTafseerValue"));
                  List<String> verses = [];
                  for (int i = firstVerse; i <= lastVerse; i++) {
                    try {
                      // Fetching the verse with end symbol
                      verses.add(getVerse(
                        surahNumber,
                        verseNumber,
                      ));
                    } catch (e) {
                      // Catch and log any issues with missing verses
                      print(
                          "No verse found for Surah $surahNumber, Verse $i: $e");
                    }
                  }

                  String contentToShare = "";

// If Tafseer is enabled, process translations
                  if (getHiveSavedDataBool("addTafseer")) {
                    String tafseer = "";

                    for (int verseNumber = firstVerse;
                        verseNumber <= lastVerse;
                        verseNumber++) {
                      try {
                        // Fetching the translation of the verse
                        String cTafseer = await translation.getVerseTranslation(
                          surahNumber,
                          verseNumber,
                          translationDataList[
                              getHiveSavedData("addTafseerValue")],
                        );

                        tafseer = "$tafseer $cTafseer ";
                      } catch (e) {
                        // Catch and log any issues with missing translations
                        print(
                            "No translation found for Surah $surahNumber, Verse $verseNumber");
                      }
                    }

                    // Creating content to share with Tafseer
                    contentToShare =
                        "{ ${verses.join('')} }[${getSurahNameArabic(surahNumber)}: $firstVerse - $lastVerse]\n\n"
                        "${translationDataList[getHiveSavedData("addTafseerValue")].typeTextInRelatedLanguage}:\n"
                        "${removeHtmlTags(tafseer)}\n\n"
                        "${getHiveSavedData("appLogo") ? "Shared with Noury" : ""}";
                  } else {
                    // Creating content to share without Tafseer
                    contentToShare =
                        "{${verses.join('')}} \n [${getSurahNameArabic(surahNumber)}: $firstVerse - $lastVerse]"
                        "${getHiveSavedData("appLogo") ? " Shared with Noury" : ""}";
                  }

// Debug print to verify the content to be shared
                  print("Content to share: $contentToShare");

// Attempt to share the content
                  try {
                    await Share.share(contentToShare, subject: "Quran Verse");
                  } catch (e) {
                    print("Error while sharing: $e");
                  }
                },
                child: Text(
                  'مشاركه كصوره ',
                  style: TextStyle(
                    color: fiveColor,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'مشاركه كنص ',
                  style: TextStyle(
                    color: fiveColor,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
