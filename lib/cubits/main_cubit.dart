import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/cubits/main_cubit_states.dart';
import 'package:quran_app/models/surah_model.dart';

class MainCubit extends Cubit<MainCubitStates> {
  MainCubit() : super(InitialMainState());

  List<SurahModel> ayaat = [];

  Future<void> getAllAyaat() async {
    emit(LoadingMainState());
    try {
      final String response =
          await rootBundle.loadString('assets/json/surahs.json');

      final List<dynamic> data = jsonDecode(response) as List<dynamic>;
      ayaat = data.map((json) => SurahModel.fromjson(json)).toList();
      emit(SuccessMainState());
    } catch (e) {
      emit(
        ErrorMainState(errorMessage: e.toString()),
      );
    }
  }
}
