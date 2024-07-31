abstract class MainCubitStates {}

class InitialMainState extends MainCubitStates {}

class LoadingMainState extends MainCubitStates {}

class SuccessMainState extends MainCubitStates {}

class SuccessdState extends MainCubitStates {}

class ErrorMainState extends MainCubitStates {
  final String errorMessage;

  ErrorMainState({required this.errorMessage});
}

class ChangeAppModeState extends MainCubitStates {}
