import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:quran/quran.dart';
import 'package:quran_app/constant/colors.dart';
import 'package:quran_app/constant/style.dart';
import 'package:quran_app/features/quranDetails/ui/widgets/basmala.dart';
import 'package:quran_app/features/quranDetails/ui/widgets/custom_ayaa_option_feature.dart';
import 'package:quran_app/features/quranDetails/ui/widgets/custom_page_namber.dart';
import 'package:quran_app/features/quranDetails/ui/widgets/cutom_button_sheet.dart';
import 'package:quran_app/features/quranDetails/ui/widgets/header_widget.dart';

import 'package:quran_app/features/quranDetails/ui/widgets/quran_start.dart';
import 'package:quran_app/features/quranDetails/ui/widgets/show_bottom_sheet_ayaa_feature.dart';
import 'package:quran_app/features/quranDetails/ui/widgets/surah_header_name.dart';
import 'package:quran_app/features/quranList/logic/models/surah_model.dart';

import 'package:wakelock_plus/wakelock_plus.dart';

class SurahDetailsPage extends StatefulWidget {
  const SurahDetailsPage({
    super.key,
    required this.pageNumber,
    required this.jsonData,
    required this.highlightVerse,
    required this.shouldHighlightText,
    required this.shouldHighlightSura,
  });
  final int pageNumber;
  final List<SurahModel> jsonData;
  final bool shouldHighlightText;
  final String highlightVerse;
  final bool shouldHighlightSura;

  @override
  State<SurahDetailsPage> createState() => _SurahDetailsPageState();
}

class _SurahDetailsPageState extends State<SurahDetailsPage> {
  late int index;
  late PageController _pageController;
  late Timer timer;
  String textSpan = '';
  late String highlightVerse;
  late bool shouldHighlightText;
  late bool shouldHighlightSura;
  late String juz;

  List<GlobalKey> richTextKeys = List.generate(604, (_) => GlobalKey());
  void highlightVerseFunction() {
    setState(() {
      shouldHighlightText = widget.shouldHighlightText;
    });

    if (widget.shouldHighlightText) {
      setState(() {
        highlightVerse = widget.highlightVerse;
      });

      // Timer to manage the blinking effect
      Timer.periodic(const Duration(milliseconds: 400), (timer) {
        if (mounted) {
          setState(() {
            // Toggle the highlight state to create the blinking effect
            shouldHighlightText = !shouldHighlightText;
          });
        }

        // Stop the timer after 5 ticks (2 seconds)
        if (timer.tick == 5) {
          if (mounted) {
            setState(() {
              highlightVerse = ""; // Clear the highlighted verse
              shouldHighlightText = false; // Ensure highlighting is turned off
            });
          }
          timer.cancel(); // Cancel the timer
        }
      });
    }
  }

  Future<void> changeHighlightSurah() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      shouldHighlightSura = false;
    });
  }

  @override
  void initState() {
    shouldHighlightSura = widget.shouldHighlightSura;
    index = widget.pageNumber;
    _pageController = PageController(initialPage: index);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    WakelockPlus.enable();
    highlightVerseFunction();
    changeHighlightSurah();

    super.initState();
    print(index);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    WakelockPlus.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.horizontal,
        onPageChanged: (a) {
          setState(() {
            textSpan = "";
          });
          index = a;
        },
        controller: _pageController,
        itemCount: totalPagesCount + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const QuranStart();
          }
          return SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: Column(
              children: [
                SurahHeaderName(
                  widget: widget,
                  index: index,
                ),
                if (index == 1 || index == 2)
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .15,
                  ),
                SizedBox(
                  height: 15.h,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          RichText(
                            locale: const Locale("ar"),
                            key: richTextKeys[index - 1],
                            softWrap: true,
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 26.sp,
                                ),
                                children: formatPageSpans(index)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                CustomPageNumber(
                  index: index,
                )
              ],
            ),
          );
        },
      ),
    );
  }

  List<InlineSpan> formatPageSpans(int index) {
    return getPageData(index).expand((e) {
      List<InlineSpan> span = [];
      for (var i = e['start']; i <= e['end']; i++) {
        if (i == 1) {
          span.add(
              WidgetSpan(child: HeaderWidget(e: e, jsonData: widget.jsonData)));
          if (index != 187 && index != 1) {
            span.add(const WidgetSpan(child: Basmala(index: 1)));
          }
          if (index == 187) {
            span.add(WidgetSpan(child: Container(height: 10.h)));
          }
        }
        span.add(TextSpan(
            recognizer: LongPressGestureRecognizer()
              ..onLongPress = () {
                showBottomSheetAyaaFeature(context);
              }
              ..onLongPressDown = (details) {
                setState(() {
                  textSpan = " ${e["surah"]}$i";
                });
              }
              ..onLongPressUp = () {
                setState(() {
                  textSpan = "";
                });
              }
              ..onLongPressCancel = () {
                setState(() {
                  textSpan = "";
                });
              },
            text: formatVerseText(e, i),
            style: TextStyle(
                color: Colors.black,
                height: (index == 1 || index == 2) ? 2 : 1.95,
                letterSpacing: 0,
                wordSpacing: 0,
                fontFamily: "QCF_P${index.toString().padLeft(3, "0")}",
                fontSize: responsiveFontSize(context, fontSize: 25.sp),
                backgroundColor: _getBackgroundColor(
                  e["surah"],
                  i,
                ))));
      }
      return span;
    }).toList();
  }

  String formatVerseText(dynamic e, int i) {
    String verse = getVerseQCF(e['surah'], i).replaceAll(" ", "");
    return (i == e['start'])
        ? "${verse.substring(0, 1)}\u200A${verse.substring(1)}"
        : verse;
  }

  String normalizeText(String text) {
    // Remove special verse end symbols and normalize Arabic text
    return text
        .replaceAll(
            RegExp(r'[^\u0600-\u06FF\s]'), '') // Remove non-Arabic characters
        .trim()
        .toLowerCase(); // Normalize to lowercase
  }

  Color _getBackgroundColor(int surah, int verse) {
    String currentVerse = normalizeText(getVerse(surah, verse));
    String highlightVerseTrimmed = normalizeText(widget.highlightVerse);

    print("Current Verse: '$currentVerse'");
    print("Highlight Verse: '$highlightVerseTrimmed'");

    // Use `contains` instead of `==` to check if the highlight contains the current verse
    bool shouldHighlight = highlightVerseTrimmed.contains(currentVerse);

    print("Should highlight: $shouldHighlight");

    if (widget.shouldHighlightText) {
      return (shouldHighlight || textSpan == " $surah$verse")
          ? Colors.orange.withOpacity(0.25)
          : Colors.transparent;
    } else {
      return textSpan == " $surah$verse"
          ? Colors.orange.withOpacity(0.25)
          : Colors.transparent;
    }
  }
}
