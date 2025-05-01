import 'package:flutter/material.dart';
import 'package:gameshowcase/app/services/app.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
  }

  XFile? avatarFile; // Avatar dosyası

  // Avatar seçme fonksiyonu
  Future<void> pickAvatar() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    ); // Galeriye yönlendirme

    if (pickedFile != null) {
      avatarFile = XFile(pickedFile.path); // Avatar dosyasını seçtikten sonra
      Get.snackbar('Avatar Seçildi', 'Avatar başarıyla seçildi!');
    } else {
      Get.snackbar('Hata', 'Avatar seçimi yapılmadı!');
    }
  }

  // Kayıt işlemi
  Future<void> registerAccount() async {
    if (avatarFile == null) {
      Get.snackbar('Hata', 'Avatar seçilmedi!');
      return;
    }

    // API'ye doğru parametrelerle istek gönder
    final response = await App.apiService.register(
      username: username.value.text,
      mail: email.value.text,
      password: password.value.text,
      avatar: avatarFile!, // Avatar dosyasını geçiriyoruz
      birthDate: "1990-01-01",
    );

    if (response != null && response.statusCode == 200) {
      Get.snackbar('Başarılı', 'Hesap oluşturuldu!');
    } else {
      Get.snackbar('Hata', 'Hesap oluşturulurken bir sorun oluştu.');
    }
  }
}
