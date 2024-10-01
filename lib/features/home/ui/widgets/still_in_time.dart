import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/features/home/logic/cubits/main_cubit.dart';

class CounterTimer extends StatefulWidget {
  const CounterTimer({super.key, required this.prayerTime});
  final DateTime prayerTime;

  @override
  State<CounterTimer> createState() => _CounterTimerState();
}

class _CounterTimerState extends State<CounterTimer> {
  late Timer _timer;

  Duration _difference = Duration.zero;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      calculateDifference();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void calculateDifference() {
    final now = DateTime.now();
    if (widget.prayerTime.isAfter(now)) {
      setState(() {
        _difference = widget.prayerTime.difference(now);
      });
    } else {
      _difference = Duration.zero;
    }
  }

  @override
  Widget build(BuildContext context) {
    int hours = _difference.inHours;
    int minutes = _difference.inMinutes.remainder(60);
    int seconds = _difference.inSeconds.remainder(60);

    return Text(
      'الباقي من الزمن  ${hours.toString().padLeft(2, '0')} : ${minutes.toString().padLeft(2, '0')} :${seconds.toString().padLeft(2, '0')}',
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 17.sp,
            color: const Color(0xff385974),
          ),
    );
  }
}
