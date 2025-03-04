import 'package:flutter/material.dart';

import 'package:get/get.dart';

class LoginController extends GetxController {
  var userNameController = TextEditingController().obs;
  var userPasswordController = TextEditingController().obs;
  var loginStatus = false.obs;
  Future<void> login() async {
    if (loginStatus.value) {
      return;
    }

    if (userNameController.value.text == '' ||
        userPasswordController.value.text == '') {
      return;
    }
    // loginStatus.value = true;
    // LoginResponse response = await Armoyu.service.authServices.login(
    //     username: userNameController.value.text,
    //     password: userPasswordController.value.text);
    // loginStatus.value = false;

    // if (!response.result.status ||
    //     response.result.description == 'Oyuncu bilgileri yanlış!') {
    //   Get.snackbar('hata', 'kullanıcı adı yada şifre yalnış...');
    //   return;
    //   }
    //   User user = User(
    //     id: response.response!.playerID!,
    //     name: response.response!.displayName!,
    //     email: response.response!.detailInfo!.email!,
    //     createdAt: response.response!.registeredDate!,
    //     avatar: response.response!.avatar!.mediaURL.normalURL,
    //     username: response.response!.username!,
    //   );
    //   response.response!.firstName!;
    //   log(response.response!.cinsiyet!);
    //   Applist.storage.write('user', user.toJson());
    //   // Get.offAndToNamed('home');
    //   Functions.golink('home');
  }
}
