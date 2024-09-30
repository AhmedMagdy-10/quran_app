import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:jhijri/_src/_jHijri.dart';

import 'package:quran_app/features/home/ui/widgets/feature_item.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final jHijri1 =
        JHijri(fDate: DateTime.now(), fDisplay: DisplayFormat.DDDMMMYYYY);

    initializeDateFormatting("ar_SA", null);
    var currentDate = DateTime.now();
    var formatDate = DateFormat.yMMMMEEEEd('ar').format(currentDate);

    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Center(
        child: Column(
          children: [
            // Text(
            //   jHijri1.toString(),
            //   style: Theme.of(context).textTheme.titleMedium,
            // ),
            // SizedBox(
            //   height: 10.h,
            // ),
            Text(
              formatDate,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontFamily: 'Cairo'),
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              'صلاة الظهر',
              style: Theme.of(context).textTheme.titleLarge,
            ),

            Text(
              '12:06 pm',
              style: Theme.of(context).textTheme.titleLarge,
            ),

            Text(
              'باقي من الزمن 5 ساعات',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 17.sp,
                    color: const Color(0xff385974),
                  ),
            ),

            SizedBox(
              height: 16.h,
            ),

            const FeaturesItemList(),
          ],
        ),
      ),
    );
  }
}
