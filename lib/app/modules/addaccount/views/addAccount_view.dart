import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gameshowcase/app/modules/addAccount/controllers/addAccount_controller.dart';

class AddaccountView extends StatelessWidget {
  const AddaccountView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddaccountController());

    return Scaffold(
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
          Center(
            child: SizedBox(
              width: Get.width / 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "HESAP OLUŞTUR",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controller.username.value,
                      decoration: InputDecoration(
                        labelText: 'KULLANICI ADI',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controller.email.value,
                      decoration: InputDecoration(
                        labelText: 'E POSTA',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controller.password.value,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'ŞIFRE',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controller.rePassword.value,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'ŞIFRE TEKRAR',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  // Avatar seçme butonu
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: controller.pickAvatar,
                      child: Text("Avatar Seç"),
                    ),
                  ),
                  // Hesap oluştur butonu
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        controller.registerAccount();
                      },
                      child: Text("Hesap Oluştur"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
