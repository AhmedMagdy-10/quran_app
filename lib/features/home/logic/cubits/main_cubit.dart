import 'package:adhan/adhan.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quran_app/core/helper/cache_helper.dart';

import 'package:quran_app/features/home/logic/cubits/main_cubit_states.dart';

class MainCubit extends Cubit<MainCubitStates> {
  MainCubit() : super(InitialMainState());

  bool isDark = false;

  void changeAppMode() {
    isDark = !isDark;
    CacheHelper.saveData(key: 'isDark', value: isDark).then((v) {
      emit(ChangeAppModeState());
    });
  }

  PrayerTimes? prayerTimes;
  final double defaultLatitude = 30.033333;
  final double defaultLongitude = 31.233334;

  getPrayerTimes() {
    emit(LoadingState());
    try {
      final coordinates = position != null
          ? Coordinates(position!.latitude, position!.longitude)
          : Coordinates(defaultLatitude, defaultLongitude);
      final calculationCountry = CalculationMethod.egyptian.getParameters();
      final date = DateComponents(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
      prayerTimes = PrayerTimes(
        coordinates,
        date,
        calculationCountry,
      );
      emit(SuccessPrayerState());
      return prayerTimes;
    } catch (e) {
      emit(
        ErrorPrayerState(errorMassage: e.toString()),
      );
      print(e.toString());
    }
  }

  Position? position;

  void getMyLoaction() async {
    emit(LoadingState());

    LocationPermission premission = await Geolocator.checkPermission();

    if (premission == LocationPermission.denied) {
      premission = await Geolocator.requestPermission();

      if (premission == LocationPermission.denied) {
        emit(PremissionError(errorPre: 'Location permissions are denied'));
        getPrayerTimes();
        return;
      }
    }
    try {
      // Try to get the current position
      position = await Geolocator.getCurrentPosition();
      if (position != null) {
        print('Position: ${position!.latitude}, ${position!.longitude}');
        emit(GetPositionSuccess());
      }
    } catch (e) {
      emit(PremissionError(errorPre: e.toString()));
    }

    // Call getPrayerTimes even if position is null (fallback to Cairo)
    getPrayerTimes();
  }
}
