import 'package:armoyu_services/armoyu_services.dart';
import 'package:flutter/material.dart';
import 'package:gameshowcase/app/services/app.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AdminNewsController extends GetxController {
  Rxn<List<News>> newsList = Rxn();
  var pagecount = 1.obs;
  var maxPagecount = 1.obs;

  Future<void> removeNews(int index) async {
    http.Response? response =
        await App.apiService.newsRemove(id: newsList.value![index].id);
    if (response != null && response.statusCode == 204) {
      newsList.value!.removeAt(index);

      newsList.refresh();
      Get.back();
    } else {
      log('Hata: ${response?.statusCode}');
      log('Hata: ${response?.body}');
      Get.snackbar('Hata', 'Haber silinmedi!');
    }
  }

  XFile? avatarFile;

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

  void showAddNewsDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController titleController = TextEditingController();
    TextEditingController textController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text('Yeni Haber Ekle'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: 'Haber adını Girin'),
            ),
            TextField(
              controller: titleController,
              decoration:
                  const InputDecoration(hintText: 'Haber Başlığını Girin'),
            ),
            TextField(
              controller: textController,
              decoration:
                  const InputDecoration(hintText: 'Haber içeriğini Girin'),
            ),
            ElevatedButton(
                onPressed: () {
                  pickAvatar();
                },
                child: const Text('Resim Seç')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('İptal')),
          TextButton(
            onPressed: () async {
              if (avatarFile == null) {
                Get.snackbar("hata", "banner seçin");
                return;
              }

              http.Response? response = await App.apiService.newsAdd(
                name: nameController.text,
                title: titleController.text,
                text: textController.text,
                banner: avatarFile!,
              );

              if (response != null && response.statusCode == 201) {
                Get.back();
                fetchnewsList();
              } else {
                log('Hata: ${response?.statusCode}');
                log('Hata: ${response?.body}');
                Get.snackbar('Hata', 'Haber eklenemedi!');
              }
            },
            child: const Text('Ekle'),
          ),
        ],
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();

    fetchnewsList();
  }

  fetchnewsList() async {
    http.Response? response =
        await App.apiService.newsList(page: pagecount.value);

    if (response != null && response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      newsList.value = [];
      for (var element in responseData['data']) {
        newsList.value!.add(
          News(
            id: element['id'],
            name: element['name'],
          ),
        );
      }
      int totalCount = responseData['totalCount'];
      maxPagecount.value =
          (totalCount % 10 == 0) ? (totalCount ~/ 10) : (totalCount ~/ 10) + 1;
      newsList.refresh();
    }
  }
}

class News {
  int id;
  String name;

  News({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}
