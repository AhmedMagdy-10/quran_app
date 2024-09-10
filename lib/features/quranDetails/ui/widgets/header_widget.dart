import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/quran.dart';
import 'package:quran/surah_data.dart';

class HeaderWidget extends StatelessWidget {
  HeaderWidget({
    super.key,
    required this.e,
    required this.jsonData,
  });

  var e;
  var jsonData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/image/888-02-Recovered.png',
              width: MediaQuery.sizeOf(context).width.w,
              height: 50,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.7.w, vertical: 7.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "اياتها\n${getVerseCount(e['surah'])}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 10,
                    fontFamily: 'uthmanic',
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Center(
                  child: Text(
                    getSurahNameArabic(
                      e["surah"],
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: "uthmanic",
                      fontSize: 22,
                    ),
                  ),
                ),
                Text(
                  "ترتيبها\n${e['surah']}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 10,
                    fontFamily: 'uthmanic',
                    fontWeight: FontWeight.w800,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
