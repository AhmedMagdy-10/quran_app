import 'package:flutter/material.dart';
import 'package:quran_app/models/feature_model.dart';
import 'package:quran_app/views/quran_page.dart';

class FeaturesItemList extends StatelessWidget {
  const FeaturesItemList({
    super.key,
  });

  static List<FeatureModel> itemList = const [
    FeatureModel(
      itemImage: 'assets/image/islam.png',
      itemText: 'الصوتيات',
      navigatorScreen: QuranPage(),
    ),

    FeatureModel(
      itemImage: 'assets/image/muhammed.png',
      itemText: 'الحديث',
      navigatorScreen: QuranPage(),
    ),
    FeatureModel(
      itemImage: 'assets/image/azkar.png',
      itemText: 'الاذكار والادعية',
      navigatorScreen: QuranPage(),
    ),
    //////////////////

    FeatureModel(
      itemImage: 'assets/image/qibla.png',
      itemText: 'القبلة',
      navigatorScreen: QuranPage(),
    ),

    FeatureModel(
      itemImage: 'assets/image/allah.png',
      itemText: 'اسماء الله الحسني',
      navigatorScreen: QuranPage(),
    ),
    FeatureModel(
      itemImage: 'assets/image/tasbih.png',
      itemText: 'السبحه',
      navigatorScreen: QuranPage(),
    ),
    ////////////////

    FeatureModel(
      itemImage: 'assets/image/microphone.png',
      itemText: 'بودكاست',
      navigatorScreen: QuranPage(),
    ),

    FeatureModel(
      itemImage: 'assets/image/ramadan.png',
      itemText: 'الاذان',
      navigatorScreen: QuranPage(),
    ),
    FeatureModel(
      itemImage: 'assets/image/bell.png',
      itemText: 'الاشعارات',
      navigatorScreen: QuranPage(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QuranPage(),
                  ));
            },
            child: Container(
              height: MediaQuery.sizeOf(context).height * 0.18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/image/book.png',
                    height: MediaQuery.sizeOf(context).height * 0.07,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text('القران الكريم',
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 12),
              itemBuilder: (context, index) => FeatureItem(
                featureModel: itemList[index],
              ),
              itemCount: itemList.length,
            ),
          ),
        ],
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  const FeatureItem({
    super.key,
    required this.featureModel,
  });

  final FeatureModel featureModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => featureModel.navigatorScreen,
            ));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              featureModel.itemImage,
              height: MediaQuery.sizeOf(context).height * 0.05,
            ),
            const SizedBox(
              height: 5,
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(featureModel.itemText,
                  style: Theme.of(context).textTheme.titleMedium),
            ),
          ],
        ),
      ),
    );
  }
}
