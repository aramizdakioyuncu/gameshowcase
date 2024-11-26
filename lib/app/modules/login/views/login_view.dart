import 'package:flutter/material.dart';
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
                    "giriş yap",
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
                      decoration: InputDecoration(
                        labelText: ' sifre',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (controller.userNameController.value.text ==
                                'mahmut' &&
                            controller.userPasswordController.value.text ==
                                '12345') {
                          Get.offAndToNamed('home');
                        }
                      },
                      child: Text('giris yap')),
                  ElevatedButton(
                      onPressed: () {
                        Get.toNamed('addAccount');
                      },
                      child: Text('hesap olustur'))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
