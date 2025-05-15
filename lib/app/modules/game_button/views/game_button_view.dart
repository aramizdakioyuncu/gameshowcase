import 'package:flutter/material.dart';
import 'package:gameshowcase/app/modules/game_button/controllers/game_button_controller.dart';
import 'package:gameshowcase/app/widgets/appbar_widget.dart';
import 'package:gameshowcase/app/widgets/menu_widget.dart';
import 'package:get/get.dart';

class GameButtonView extends StatelessWidget {
  const GameButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(GameButtonController());

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
            const Center(
              child: Text(
                  'OYUNUMUZ HENÜZ YAPIM AŞAMASINDADIR , EN KISA SÜRE ZARFINDA OYUN HAKKINDA BİLGİLERİ BURADA GÖRÜNTÜLEYE BİLİRSİNİZ.'),
            ),
          ],
        ));
  }
}
