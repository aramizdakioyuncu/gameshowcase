import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminEventsController extends GetxController {
  var eventsList = <String>[].obs; // Observable liste tanımlandı

  void addEvent(String event) {
    eventsList.add(event);
  }

  void removeEvent(int index) {
    if (index >= 0 && index < eventsList.length) {
      eventsList.removeAt(index);
    }
  }

  void showAddEventDialog() {
    TextEditingController textController = TextEditingController();
    Get.defaultDialog(
      title: "Etkinlik Ekle",
      content: TextField(
        controller: textController,
        decoration: const InputDecoration(hintText: "Etkinlik başlığını girin"),
      ),
      confirm: ElevatedButton(
        onPressed: () {
          if (textController.text.isNotEmpty) {
            addEvent(textController.text);
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
