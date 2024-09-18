import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/quran.dart';

import '../../features/quranDetails/logic/translation/get_translation_data.dart'
    as translate;

Future<List<InlineSpan>> buildTafseerSpans(
    int surahNumber,
    int firstVerseNumber,
    int lastVerseNumber,
    translatee,
    int? indexOfTheme) async {
  List<InlineSpan> tafseerSpans = [];

  for (int verseNumber = firstVerseNumber;
      verseNumber <= lastVerseNumber;
      verseNumber++) {
    String verseText = getVerse(surahNumber, verseNumber);
    String text = await translate.getVerseTranslation(
        surahNumber, verseNumber, translatee);
    text = text.replaceAll("<p>", "\n").replaceAll("</p>", "");
    TextSpan translateSpan = TextSpan(
      text: text,
      // recognizer: LongPressGestureRecognizer()..onLongPress = () {},
      style: TextStyle(
        fontSize: 14.sp,
        fontFamily: "taha",
        // fontFamily: getValue("selectedFontFamily"),
      ),
    );

    tafseerSpans.add(translateSpan);
    // tafseerSpans.add(
    //   TextSpan(
    //       locale: const Locale("ar"),
    //       text:
    //           " ${convertToArabicNumber((verseNumber).toString())} " //               quran.getVerseEndSymbol()
    //       ,
    //       style: const TextStyle(
    //         color: secondaryColors[indexOfTheme],
    //       )),
    // );
  }

  return tafseerSpans;
}
