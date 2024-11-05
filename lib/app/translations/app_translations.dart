import 'package:gameshowcase/app/translations/az.dart';
import 'package:gameshowcase/app/translations/en.dart';
import 'package:gameshowcase/app/translations/tr.dart';

abstract class AppTranslation {
  static Map<String, Map<String, String>> translationKeys = {
    'en': en,
    'tr': tr,
    'az': az,
  };
}
