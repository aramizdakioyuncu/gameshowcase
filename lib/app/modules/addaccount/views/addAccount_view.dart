import 'package:flutter/material.dart';
import 'package:gameshowcase/app/modules/addAccount/controllers/addAccount_controller.dart';
import 'package:get/get.dart';

class AddaccountView extends StatelessWidget {
  const AddaccountView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddaccountController());

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
                    "hesap oluştur",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'AD',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'SOYAD',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'KULLANICI ADI',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'E POSTA',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Obx(
                    () => Padding(
                      padding: EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        value: controller.selectedGender.value == ''
                            ? null
                            : controller.selectedGender.value,
                        hint: const Text("Cinsiyet Seçiniz"),
                        items: List.generate(
                          controller.genders.length,
                          (index) {
                            return DropdownMenuItem(
                              value: controller.genders[index],
                              child: Text(controller.genders[index]),
                            );
                          },
                        ),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            controller.selectedGender.value = newValue;
                          }
                        },
                      ),
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
