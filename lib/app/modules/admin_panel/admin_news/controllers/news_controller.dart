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

  void showEditNewsDialog(News existingNews) async {
    // Haberi API'den çek
    http.Response? response =
        await App.apiService.newsDetail(id: existingNews.id);
    String title = '';
    String text = '';

    if (response != null && response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      title = responseData['title'] ?? '';
      text = responseData['text'] ?? '';
    }

    TextEditingController nameController =
        TextEditingController(text: existingNews.name);
    TextEditingController titleController = TextEditingController(text: title);
    TextEditingController textController = TextEditingController(text: text);

    Get.dialog(
      AlertDialog(
        title: const Text('Haberi Düzenle'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: 'Haber adını girin'),
            ),
            TextField(
              controller: titleController,
              decoration:
                  const InputDecoration(hintText: 'Haber başlığını girin'),
            ),
            TextField(
              controller: textController,
              decoration:
                  const InputDecoration(hintText: 'Haber içeriğini girin'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('İptal')),
          TextButton(
            onPressed: () async {
              http.Response? response = await App.apiService.newsEdit(
                id: existingNews.id,
                name: nameController.text,
                title: titleController.text,
                text: textController.text,
              );

              if (response != null &&
                  (response.statusCode == 200 || response.statusCode == 204)) {
                Get.back();
                fetchnewsList();
                Get.snackbar('Başarılı', 'Haber başarıyla güncellendi!');
              } else {
                log('Hata: ${response?.statusCode}');
                log('Hata: ${response?.body}');
                Get.snackbar('Hata', 'Haber güncellenemedi!');
              }
            },
            child: const Text('Güncelle'),
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
        await App.apiService.newsListToPanel(page: pagecount.value);

    if (response != null && response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      newsList.value = [];
      for (var element in responseData['data']) {
        newsList.value!.add(
          News(
            id: element['id'],
            name: element['name'],
            title: element['title']?['tr'] ?? '', // API'den gelen title
            text: element['text']?['tr'] ?? '', // API'den gelen text
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
  String title;
  String text;

  News({
    required this.id,
    required this.name,
    required this.title,
    required this.text,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'title': title,
      'text': text,
    };
  }

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'] as int,
      name: json['name'] as String,
      title: json['title']?['tr'] as String? ?? '',
      text: json['text']?['tr'] as String? ?? '',
    );
  }
}
