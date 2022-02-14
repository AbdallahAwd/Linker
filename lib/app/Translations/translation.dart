import 'package:get/get.dart';
import 'package:linker/app/Translations/ar.dart';
import 'package:linker/app/Translations/en.dart';
import 'package:linker/app/Translations/es.dart';

class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'ar_EG': ar,
        'es_ES': es,
      };
}
