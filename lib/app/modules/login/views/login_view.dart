import 'package:flutter/material.dart';
import 'package:gameshowcase/app/functions/functions.dart';
import 'package:gameshowcase/app/modules/login/controlers/login_controller.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'wallpapers/login.jpg',
            fit: BoxFit.cover,
            height: Get.height,
            width: Get.width,
          ),
          Center(
            child: SizedBox(
              width: Get.width / 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "GİRİŞ YAP",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controller.userNameController.value,
                      decoration: InputDecoration(
                        labelText: 'kullanici adi',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controller.userPasswordController.value,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: ' sifre',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  _buildNavButton('GİRİŞ YAP', 'login'),
                  _buildNavButton('HESAP OLUŞTUR', 'addAccount'),

                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Obx(
                  //     () => Armoyu.widgets.elevatedButton.costum1(
                  //       text: 'giris yap',
                  //       onPressed: () {
                  //         controller.login();
                  //       },
                  //       loadingStatus: controller.loginStatus.value,
                  //     ),
                  //   ),
                  // ),
                  // Armoyu.widgets.elevatedButton.costum1(
                  //     text: 'hesap oluştur',
                  //     onPressed: () {
                  //       // Get.toNamed('addAccount');
                  //       Functions.golink('addAccount');
                  //     },
                  //     loadingStatus: false)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(String text, String route) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          Functions.golink(route);
        },
        child: Text(text),
      ),
    );
  }
}
