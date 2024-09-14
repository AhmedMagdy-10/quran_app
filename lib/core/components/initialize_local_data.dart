import 'package:quran_app/core/helper/hive_helper.dart';

localHiveData() async {
  savedDateHive('appLogo', true);
  savedDateHive("showSuraHeader", true);
  savedDateHive("addTafseer", true);
  savedDateHive("addTafseerValue", 0);
}
