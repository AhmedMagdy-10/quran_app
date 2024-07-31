import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:jhijri/_src/_jHijri.dart';

import 'package:quran_app/widgets/feature_item.dart';

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
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              jHijri1.toString(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              formatDate,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 16,
            ),
            const FeaturesItemList(),
          ],
        ),
      ),
    );
  }
}
