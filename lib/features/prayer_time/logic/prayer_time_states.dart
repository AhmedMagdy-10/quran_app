abstract class PrayerTimeStates {}

class InitialPrayerState extends PrayerTimeStates {}

class LoadingPrayerState extends PrayerTimeStates {}

class SuccessPrayerState extends PrayerTimeStates {}

class ErrorPrayerState extends PrayerTimeStates {
  final String errorMassage;

  ErrorPrayerState({required this.errorMassage});
}
