import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/constant/colors.dart';

class CustomPageNumber extends StatelessWidget {
  const CustomPageNumber({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0).w,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 20.h),
        decoration: BoxDecoration(
          color: fourColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          "$index",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 29, 169, 173),
          ),
        ),
      ),
    );
  }
}
