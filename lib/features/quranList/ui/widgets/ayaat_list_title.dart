import 'package:flutter/material.dart';
import 'package:quran_app/constant/colors.dart';
import 'package:quran_app/features/quranList/logic/models/surah_model.dart';

class AyaatListTitle extends StatelessWidget {
  const AyaatListTitle({
    super.key,
    required this.ayah,
  });

  final SurahModel ayah;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        ayah.name,
        style: const TextStyle(
          fontSize: 20,
          fontFamily: 'AmiriQuran',
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Text(
        ayah.englishName,
        style: const TextStyle(
          fontSize: 18,
          color: Color.fromARGB(255, 29, 169, 173),
        ),
      ),
      subtitle: Text(
        "${ayah.numberOfAyahs.toString()} عدد الايات",
        style: TextStyle(
          color: Colors.grey.withOpacity(0.8),
          fontSize: 14,
        ),
      ),
      leading: Container(
        width: 45,
        height: 45,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/sura_frame.png'),
          ),
        ),
        child: Center(
          child: Text(
            ayah.number.toString(),
            style: TextStyle(
              color: threeColor,
              fontSize: 15,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
