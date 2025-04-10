import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminNewsController extends GetxController {
  var newsList = <String>[].obs;

  void addNews(String news) {
    newsList.add(news);
  }

  void removeNews(int index) {
    newsList.removeAt(index);
  }

  void showAddNewsDialog() {
    TextEditingController newsController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text('Yeni Haber Ekle'),
        content: TextField(
          controller: newsController,
          decoration: const InputDecoration(hintText: 'Haber Başlığını Girin'),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('İptal')),
          TextButton(
            onPressed: () {
              if (newsController.text.isNotEmpty) {
                addNews(newsController.text);
                Get.back();
              }
            },
            child: const Text('Ekle'),
          ),
        ],
      ),
    );
  }
}
