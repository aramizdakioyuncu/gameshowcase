import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
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

    // Button widget to handle navigation
    Widget _buildNavButton(String text, String route) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () async {
            if (route == 'login') {
              // Login işlemleri
              var response = await App.apiService.login(
                controller.userNameController.value.text,
                controller.userPasswordController.value.text,
              );

              if (response != null && response.statusCode == 200) {
                var responseData = jsonDecode(response.body);
                String accessToken = responseData["accessToken"];

                Map<String, dynamic> decodedToken = Jwt.parseJwt(accessToken);
                String? username;
                String? userId;
                String? role;

                if (decodedToken.containsKey(
                    "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name")) {
                  username = decodedToken[
                      "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"];
                  if (kDebugMode) {
                    print("Kullanıcı name: $username");
                  }
                }

                if (decodedToken.containsKey(
                    "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier")) {
                  userId = decodedToken[
                      "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier"];
                  print("Kullanıcı id: $userId");
                }

                if (decodedToken.containsKey(
                    "http://schemas.microsoft.com/ws/2008/06/identity/claims/role")) {
                  role = decodedToken[
                      "http://schemas.microsoft.com/ws/2008/06/identity/claims/role"];
                  print("Kullanıcı rol: $role");
                }

                log('Giriş başarılı');

                // Kullanıcı bilgilerini al
                var response2 = await App.apiService.userInfo(accessToken);

                if (response2 != null && response2.statusCode == 200) {
                  log("rtyhj");
                  var responseData2 = jsonDecode(response2.body);

                  Applist.currentuser = User(
                    id: int.parse(userId!),
                    token: accessToken,
                    name: responseData2['username'],
                    avatar:
                        'http://185.93.68.107/api/Documents/cd071d3d-b85e-4a4e-bf89-f411297b89d5/${responseData2['avatarId'].toString()}',
                    username: responseData2['username'],
                    role: role ?? 'User',
                  );

                  Applist.storage.write('user', Applist.currentuser!.toJson());
                  Functions.golink('/');
                }
              }
              return;
            } else if (route == 'addAccount') {
              // Hesap oluşturma butonuna tıklanınca yönlendirme işlemi
              Get.toNamed('/addAccount'); // 'addAccount' sayfasına yönlendir
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
            'assets/wallpapers/login.gif',
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
                    "GİRİŞ YAP",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controller.userNameController.value,
                      decoration: const InputDecoration(
                        labelText: 'Kullanıcı Adı',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controller.userPasswordController.value,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Şifre',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  _buildNavButton('GİRİŞ YAP', 'login'),
                  _buildNavButton('HESAP OLUŞTUR', 'addAccount'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
