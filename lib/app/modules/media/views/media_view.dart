import 'package:flutter/material.dart';
import 'package:gameshowcase/app/modules/media/controllers/media_controller.dart';
import 'package:gameshowcase/app/widgets/appbar_widget.dart';
import 'package:gameshowcase/app/widgets/menu_widget.dart';
import 'package:get/get.dart';

class MediaView extends StatelessWidget {
  const MediaView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MediaController());

    return Scaffold(
        appBar: AppbarWidget.appbar1(),
        body: Stack(
          children: [
           Image.asset(
            'wallpapers/login.gif',
            fit: BoxFit.cover,
            height: Get.height,
            width: Get.width,
          ),
          Container(
            height: Get.height,
            width: Get.width,
            color: Colors.black.withOpacity(0.75), // karanlık efekti
          ),
            MenuWidget.menu(),
          ],
        ));
  }
}
