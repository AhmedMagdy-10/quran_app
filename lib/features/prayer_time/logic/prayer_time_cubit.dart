// import 'package:adhan/adhan.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:quran_app/features/prayer_time/logic/prayer_time_states.dart';

// class PrayerTimeCubit extends Cubit<PrayerTimeStates> {

//   PrayerTimeCubit() : super(InitialPrayerState());

//   PrayerTimes? prayerTimes;

//   void getPrayerTimes() async {
//     emit(LoadingPrayerState());

//     try {
//       final Position myPosition = await Geolocator.getCurrentPosition();

//       final coordinates =
//           Coordinates(myPosition.latitude, myPosition.longitude);
//       final calculationCountry = CalculationMethod.egyptian.getParameters();
//       final date = DateComponents(
//           DateTime.now().year, DateTime.now().month, DateTime.now().day);
//       prayerTimes = PrayerTimes(
//         coordinates,
//         date,
//         calculationCountry,
//       );
//       emit(SuccessPrayerState());
//     } catch (e) {
//       emit(
//         ErrorPrayerState(errorMassage: e.toString()),
//       );
//     }
//   }
// }
