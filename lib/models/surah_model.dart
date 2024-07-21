class SurahModel {
  final String name;
  final int number;
  final String englishName;
  final int numberOfAyahs;

  SurahModel({
    required this.name,
    required this.number,
    required this.englishName,
    required this.numberOfAyahs,
  });

  factory SurahModel.fromjson(Map<String, dynamic> jsonData) {
    return SurahModel(
      name: jsonData['name'],
      number: jsonData['number'],
      englishName: jsonData['englishName'],
      numberOfAyahs: jsonData['numberOfAyahs'],
    );
  }
}
