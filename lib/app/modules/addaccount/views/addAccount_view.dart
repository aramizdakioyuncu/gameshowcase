import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gameshowcase/app/services/app.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart'; // image_picker ekleyin
import 'package:gameshowcase/app/modules/addAccount/controllers/addAccount_controller.dart';
import 'package:gameshowcase/app/services/apiservices.dart'; // API servisini ekleyin

class AddaccountView extends StatelessWidget {
  const AddaccountView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddaccountController());
    File? avatarFile; // Avatar dosyası

    // Avatar seçme fonksiyonu
    Future<void> _pickAvatar() async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
      ); // Galeriye yönlendirme

      if (pickedFile != null) {
        avatarFile = File(pickedFile.path); // Avatar dosyasını seçtikten sonra
        Get.snackbar('Avatar Seçildi', 'Avatar başarıyla seçildi!');
      } else {
        Get.snackbar('Hata', 'Avatar seçimi yapılmadı!');
      }
    }

    Future<void> registerAccount2() async {
      var response = await App.apiService.register2(
        username: controller.username.value.text,
        mail: controller.email.value.text,
        avatar: avatarFile,
        password: controller.password.value.text,
        birthDate: "1990-01-01",
      );

      if (response != null && response.statusCode == 200) {
        Get.snackbar('Başarılı', 'Hesap oluşturuldu!');
      } else {
        Get.snackbar('Hata', 'Hesap oluşturulurken bir sorun oluştu.');
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
        username: controller.username.value.text,
        mail: controller.email.value.text,
        password: controller.password.value.text,
        avatar: avatarFile!, // Avatar dosyasını geçiriyoruz
        birthDate:
            "1990-01-01", // Doğum tarihini burada manuel ya da kullanıcıdan alabilirsiniz
        consentsJson:
            '{"privacy": true}', // Konsens JSON (kullanıcı onayı verisi)
      );

      if (response != null && response.statusCode == 200) {
        Get.snackbar('Başarılı', 'Hesap oluşturuldu!');
      } else {
        Get.snackbar('Hata', 'Hesap oluşturulurken bir sorun oluştu.');
      }
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
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: _pickAvatar,
                      child: Text("Avatar Seç"),
                    ),
                  ),
                  // Hesap oluştur butonu
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      // onPressed: registerAccount,
                      onPressed: registerAccount2,
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
