import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gameshowcase/app/applist.dart';
import 'package:gameshowcase/app/functions/functions.dart';
import 'package:gameshowcase/app/models/user.dart';
import 'package:gameshowcase/app/modules/login/controlers/login_controller.dart';
import 'package:gameshowcase/app/services/app.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    Widget _buildNavButton(String text, String route) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () async {
            if (route == 'login') {
              var response = await App.apiService.login(
                controller.userNameController.value.text,
                controller.userPasswordController.value.text,
              );

              if (response != null && response.statusCode == 200) {
                var responseData = jsonDecode(response.body);

                String accessToken = responseData["accessToken"];

                Map<String, dynamic> decodedToken = Jwt.parseJwt(accessToken);

                if (decodedToken.containsKey(
                    "http://schemas.microsoft.com/ws/2008/06/identity/claims/role")) {
                  String userRole = decodedToken[
                      "http://schemas.microsoft.com/ws/2008/06/identity/claims/role"];
                  print("Kullanıcı Rolü: $userRole");
                } else {
                  print("Rol bulunamadı!");
                }
                String? username;
                if (decodedToken.containsKey(
                    "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name")) {
                  String username = decodedToken[
                      "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"];
                  print("Kullanıcı name: $username");
                } else {
                  print("Rol bulunamadı!");
                }

                String? userId;
                if (decodedToken.containsKey(
                    "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier")) {
                  userId = decodedToken[
                      "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier"];
                  print("Kullanıcı name: $userId");
                } else {
                  print("Rol bulunamadı!");
                }

                log('giris basarili');

                var response2 = await App.apiService.UserInfo();
                var responseData2 = jsonDecode(response2!.body);

                Applist.currentuser = User(
                  id: int.parse(userId!),
                  name: responseData2['username'],
                  avatar:
                      'http://185.93.68.107/api/Documents/cd071d3d-b85e-4a4e-bf89-f411297b89d5/${responseData2['avatarId'].toString()}',
                  username: responseData2['username'],
                );

                Applist.storage.write('user', Applist.currentuser!.toJson());
                Functions.golink('/');
              }

              return;
            }
          },
          child: Text(text),
        ),
      );
    }

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
}
