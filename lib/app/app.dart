import 'package:flutter/material.dart';
import 'package:gameshowcase/app/routes/app_routes.dart';
import 'package:gameshowcase/app/theme/app_theme.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: appThemeData,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
