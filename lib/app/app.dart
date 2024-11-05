import 'package:flutter/material.dart';
import 'package:gameshowcase/app/routes/app_routes.dart';
import 'package:gameshowcase/app/theme/app_theme.dart';
import 'package:gameshowcase/app/translations/app_translations.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: appLightThemeData,
      darkTheme: appDarkThemeData,
      themeMode: ThemeMode.light,
      initialRoute: AppPages.initial,
      locale: Get.deviceLocale,
      translationsKeys: AppTranslation.translationKeys,
      fallbackLocale: const Locale('tr', 'TR'),
      getPages: AppPages.routes,
    );
  }
}
