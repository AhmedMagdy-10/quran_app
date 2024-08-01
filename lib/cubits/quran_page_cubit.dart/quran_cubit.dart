// import 'dart:convert';

// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:quran_app/cubits/quran_page_cubit.dart/quran_states.dart';
// import 'package:quran_app/models/surah_model.dart';

// class QuranPageCubit extends Cubit<QuranPageStates> {
//   QuranPageCubit() : super(InitialQuranState());

//   List<dynamic> ayaat = [];
//   List<dynamic> data = [];

//   Future<void> getAllAyaat() async {
//     emit(LoadingQuranState());
//     try {
//       final String response =
//           await rootBundle.loadString('assets/json/surahs.json');

//       data = jsonDecode(response) as List<dynamic>;
//       ayaat = data.map((json) => SurahModel.fromjson(json)).toList();
//       emit(SuccessQuranState());
//     } catch (e) {
//       emit(
//         ErrorQuranState(errorMessage: e.toString()),
//       );
//     }
//   }

//   SurahModel? surahModel;

//   getSearchData(String searchValue) {
//     if (searchValue == '') {
//     } else if (searchValue.length > 3 || searchValue.contains(" ")) {
//       ayaat = data.where((surah) {
//         final surahName = surah['englishName'].toLowerCase();
//         return surahName.contains(searchValue.toLowerCase());
//       }).toList();
//       emit(SuccessQuranState());
//     }
//   }
// }

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/cubits/quran_page_cubit.dart/quran_states.dart';
import 'package:quran_app/models/surah_model.dart';

class QuranPageCubit extends Cubit<QuranPageStates> {
  QuranPageCubit() : super(InitialQuranState());

  List<SurahModel> ayaat = [];
  List<SurahModel> allAyaat = [];

  void getAllAyaat() async {
    emit(LoadingQuranState());
    try {
      final String response =
          await rootBundle.loadString('assets/json/surahs.json');
      final List<dynamic> data = await Future.delayed(
          const Duration(milliseconds: 500), () => json.decode(response));

      ayaat = data.map((json) => SurahModel.fromjson(json)).toList();

      allAyaat = ayaat;
      emit(SuccessQuranState());
    } catch (e) {
      emit(
        ErrorQuranState(errorMessage: e.toString()),
      );
    }
  }

  void searchAyaat(String query) {
    if (query.isEmpty) {
      ayaat = allAyaat;
    } else if (query.length > 3 || query.toString().contains(" ")) {
      ayaat = allAyaat.where((surah) {
        final surahName = surah.name.toLowerCase();

        return surahName.contains(query.toLowerCase());
      }).toList();
    }
    emit(SuccessQuranState());
  }
}
