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
  }
}
