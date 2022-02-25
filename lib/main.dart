// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:linker/app/Translations/translation.dart';
import 'package:linker/app/themes/colors.dart';
import 'package:linker/app/themes/themes.dart';
import 'app/components/splash_screen.dart';
import 'app/modules/home/controllers/home_controller.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  await GetStorage.init();
  String? uId = GetStorage().read('uId');
  String? isDark = GetStorage().read('isDark');
  isSecondColor = GetStorage().read('isSecondColor') ?? false;

  GetStorage().read('language') == null
      ? GetStorage().write('language', Get.deviceLocale.toString())
      : null;
  String language = GetStorage().read('language');
  await deviceLang(language);

  runApp(MyApp(uId, isDark, language));
}

class MyApp extends StatelessWidget {
  String? uId;
  String? isDark;
  String? language;
  MyApp(this.uId, this.isDark, this.language);
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeController());
    return GetMaterialApp(
      title: "Linker",
      translations: Localization(),
      debugShowCheckedModeBanner: false,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      themeMode: generalTheme(isDark ?? 'Follow System'),
      home: SecondPage(uId: uId),
      getPages: AppPages.routes,
    );
  }

  ThemeMode generalTheme(String isDark) {
    if (isDark == 'Follow System') return ThemeMode.system;
    if (isDark == 'Dark Mode') return ThemeMode.dark;
    return ThemeMode.light;
  }
}

Future<void> deviceLang(language) async {
  if (language == 'ar_EG' || language == 'ar_SA' || language == 'ar_AE') {
    await Get.updateLocale(const Locale('ar'));
  } else if (language == 'es_ES') {
    await Get.updateLocale(const Locale('es'));
  } else {
    await Get.updateLocale(const Locale('en'));
  }
}
