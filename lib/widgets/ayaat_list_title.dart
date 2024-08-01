import 'package:flutter/material.dart';
import 'package:quran_app/constant/colors.dart';
import 'package:quran_app/models/surah_model.dart';

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
          fontFamily: '',
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Text(
        ayah.englishName,
        style: TextStyle(
          fontSize: 18,
          color: Colors.cyan[900],
        ),
      ),
      subtitle: Text(
        "Verse (${ayah.numberOfAyahs.toString()})",
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
