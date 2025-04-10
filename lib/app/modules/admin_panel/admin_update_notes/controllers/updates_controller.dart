import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminUpdatesController extends GetxController {
  var updatesList = <String>[].obs;

  void addUpdate(String update) {
    updatesList.add(update);
  }

  void removeUpdate(int index) {
    updatesList.removeAt(index);
  }

  void showAddUpdateDialog() {
    TextEditingController textController = TextEditingController();
    Get.defaultDialog(
      title: "Güncelleme Notu Ekle",
      content: TextField(
        controller: textController,
        decoration: const InputDecoration(hintText: "Güncelleme notunu girin"),
      ),
      confirm: ElevatedButton(
        onPressed: () {
          if (textController.text.isNotEmpty) {
            addUpdate(textController.text);
            Get.back();
          }
        },
        child: const Text("Ekle"),
      ),
      cancel: ElevatedButton(
        onPressed: () => Get.back(),
        child: const Text("İptal"),
      ),
    );
  }
}
