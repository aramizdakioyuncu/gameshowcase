import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddaccountController extends GetxController {
  var selectedGender = ''.obs;
  var name = TextEditingController().obs;
  var lastname = TextEditingController().obs;
  var username = TextEditingController().obs;
  var password = TextEditingController().obs;
  var rePassword = TextEditingController().obs;
  var email = TextEditingController().obs;

  var genders = <String>['Erkek', 'Kadın', 'Belirtmek istemiyorum'].obs;
  var addAccStatus = false.obs;

  Future<void> addAccount() async {
    if (password.value.text != rePassword.value.text) {
      Get.snackbar("HATA", "şifreler eşleşmedi");

      return;
    }
    if (addAccStatus.value) {
      return;
    }
    addAccStatus.value = true;

    // RegisterResponse response = await Armoyu.service.authServices.register(
    //   username: username.value.text,
    //   password: password.value.text,
    //   firstname: name.value.text,
    //   lastname: lastname.value.text,
    //   email: email.value.text,
    //   rpassword: password.value.text,
    // );
    // addAccStatus.value = false;

    // if (!response.result.status) {
    //   Get.snackbar("HATA", response.result.description);
    //   return;
    // }
    // Get.snackbar('hesabiniz olusturulmustur', response.result.description);
  }
}
