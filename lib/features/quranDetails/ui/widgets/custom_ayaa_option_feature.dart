import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/constant/colors.dart';

class CustomAyaaOptionFeature extends StatelessWidget {
  const CustomAyaaOptionFeature({
    super.key,
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: secondColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Cairo"),
            ),
            Icon(
              icon,
              color: threeColor,
            )
          ],
        ),
      ),
    );
  }
}
