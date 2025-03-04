import 'package:flutter/material.dart';
import 'package:gameshowcase/app/modules/help/controllers/help_controller.dart';
import 'package:gameshowcase/app/widgets/appbar_widget.dart';
import 'package:gameshowcase/app/widgets/menu_widget.dart';
import 'package:get/get.dart';

class HelpView extends StatelessWidget {
  const HelpView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HelpController());

    return Scaffold(
        appBar: AppbarWidget.appbar1(),
        body: Stack(
          children: [
            Image.asset(
              'wallpapers/login.jpg',
              fit: BoxFit.cover,
              height: Get.height,
              width: Get.width,
            ),
            Column(
              children: [
                MenuWidget.menu(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'DESTEK',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
