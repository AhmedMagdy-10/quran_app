import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:quran_app/constant/colors.dart';
import 'package:quran_app/features/quranDetails/ui/widgets/custom_ayaa_option_feature.dart';

Future<dynamic> showBottomSheetAyaaFeature(BuildContext context) async {
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
      return SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.5.h,
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
                  padding: const EdgeInsets.all(24).w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          ' 8 : سورة الناس ',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'ٱلۡحَمۡدُ لِلَّهِ رَبِّ ٱلۡعَٰلَمِينَ',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontFamily: "AmiriQuran"),
                          ),
                          Icon(
                            Icons.share_rounded,
                            color: threeColor,
                          )
                        ],
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
