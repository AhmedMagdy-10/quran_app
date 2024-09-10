import 'dart:async';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/quran.dart';
import 'package:quran_app/features/quranDetails/ui/widgets/basmala.dart';
import 'package:quran_app/features/quranDetails/ui/widgets/header_widget.dart';

import 'package:quran_app/features/quranDetails/ui/widgets/quran_start.dart';
import 'package:quran_app/features/quranList/logic/models/surah_model.dart';
import 'package:quran_app/generated/l10n.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class SurahDetailsPage extends StatefulWidget {
  const SurahDetailsPage({
    super.key,
    required this.pageNumber,
    required this.jsonData,
    required this.highlightVerse,
    this.shouldHighlightText,
  });
  final int pageNumber;
  final List<SurahModel> jsonData;
  final bool? shouldHighlightText;
  final String highlightVerse;

  @override
  State<SurahDetailsPage> createState() => _SurahDetailsPageState();
}

class _SurahDetailsPageState extends State<SurahDetailsPage> {
  late int index;
  late PageController _pageController;
  late Timer timer;
  String textSpan = '';
  List<GlobalKey> richTextKeys = List.generate(604, (_) => GlobalKey());
  void highlightVerse() {}

  @override
  void initState() {
    index = widget.pageNumber;
    _pageController = PageController(initialPage: index);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    WakelockPlus.enable();
    highlightVerse();
    super.initState();
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
                    padding: EdgeInsets.zero,
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
            span.add(WidgetSpan(child: Container(height: 10)));
          }
        }
        span.add(TextSpan(
            recognizer: LongPressGestureRecognizer()
              ..onLongPress = () {
                print("onlong");
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
            text: i == e['start']
                ? "${getVerseQCF(e['surah'], i).replaceAll(" ", "").substring(0, 1)}\u200A${getVerseQCF(e['surah'], i).replaceAll(" ", "").substring(1)}"
                    .replaceAll(" ", "")
                : getVerseQCF(e["surah"], i).replaceAll(" ", ""),
            style: TextStyle(
                color: Colors.black,
                height: (index == 1 || index == 2) ? 2 : 1.95,
                letterSpacing: 0,
                wordSpacing: 0,
                fontFamily: "QCF_P${index.toString().padLeft(3, "0")}",
                fontSize: index == 1 || index == 2
                    ? 28
                    : index == 145 || index == 201
                        ? index == 532 || index == 533
                            ? 23.sp
                            : 23.sp
                        : 23.sp,
                backgroundColor: _getBackgroundColor(
                  e["surah"],
                  i,
                ))));
      }
      return span;
    }).toList();
  }

  Color _getBackgroundColor(
    int surah,
    int verse,
  ) {
    if (widget.shouldHighlightText == true) {
      return getVerse(surah, verse) == widget.highlightVerse ||
              textSpan == " $surah$verse"
          ? Colors.orange.withOpacity(.25)
          : Colors.transparent;
    } else {
      return textSpan == " $surah$verse"
          ? Colors.orange.withOpacity(.25)
          : Colors.transparent;
    }
  }
}

class SurahHeaderName extends StatelessWidget {
  const SurahHeaderName({
    super.key,
    required this.widget,
    required this.index,
  });

  final SurahDetailsPage widget;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 15.w,
        left: 16.w,
        right: 16.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${S.of(context).surah} ${widget.jsonData[getPageData(index)[0]['surah'] - 1].name}',
            style: TextStyle(
              fontSize: 24.sp,
              color: const Color.fromARGB(255, 29, 169, 173),
              fontFamily: 'uthmanic',
            ),
          )
        ],
      ),
    );
  }
}
