import 'package:armoyu_services/armoyu_services.dart';
import 'package:flutter/material.dart';
import 'package:gameshowcase/app/services/app.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class AdminUpdateController extends GetxController {
  Rxn<List<Update>> updateList = Rxn();
  var pagecount = 1.obs;
  var maxPagecount = 1.obs;

  Future<void> removeUpdate(int index) async {
    http.Response? response =
        await App.apiService.updateRemove(id: updateList.value![index].id);
    if (response != null && response.statusCode == 204) {
      updateList.value!.removeAt(index);

      updateList.refresh();
      Get.back();
    } else {
      log('Hata: ${response?.statusCode}');
      log('Hata: ${response?.body}');
      Get.snackbar('Hata', 'guncelleme silinmedi!');
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

  void showAddUpdateDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController titleController = TextEditingController();
    TextEditingController textController = TextEditingController();
    TextEditingController youtubeUrlController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text('Yeni guncelleme Ekle'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration:
                  const InputDecoration(hintText: 'Guncelleme adını Girin'),
            ),
            TextField(
              controller: titleController,
              decoration:
                  const InputDecoration(hintText: 'Guncelleme Başlığını Girin'),
            ),
            TextField(
              controller: textController,
              decoration:
                  const InputDecoration(hintText: 'Guncelleme içeriğini Girin'),
            ),
            TextField(
              controller: youtubeUrlController,
              decoration: const InputDecoration(hintText: 'youtubeUrl Girin'),
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

              http.Response? response = await App.apiService.updateAdd(
                name: nameController.text,
                title: titleController.text,
                text: textController.text,
                banner: avatarFile!,
                youtubeUrl: youtubeUrlController.text,
              );

              if (response != null && response.statusCode == 201) {
                Get.back();
                fetchupdateList();
              } else {
                log('Hata: ${response?.statusCode}');
                log('Hata: ${response?.body}');
                Get.snackbar('Hata', 'guncelleme eklenemedi!');
              }
            },
            child: const Text('Ekle'),
          ),
        ],
      ),
    );
  }

  void showEditUpdateDialog(Update existingUpdate) async {
    // Haberi API'den çek
    http.Response? response =
        await App.apiService.updateDetail(id: existingUpdate.id);
    String title = '';
    String text = '';
    String youtube = '';

    if (response != null && response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      title = responseData['title'] ?? '';
      text = responseData['text'] ?? '';
      youtube = existingUpdate.youtube
      ;
    }

    TextEditingController nameController = TextEditingController(text: existingUpdate.name);
    TextEditingController titleController = TextEditingController(text: title);
    TextEditingController textController = TextEditingController(text: text);
    TextEditingController youtubeUrlController = TextEditingController(text: youtube );

    Get.dialog(
      AlertDialog(
        title: const Text('güncellemeyi Düzenle'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: 'güncelleme adını girin'),
            ),
            TextField(
              controller: titleController,
              decoration:
                  const InputDecoration(hintText: 'güncelleme başlığını girin'),
            ),
            TextField(
              controller: textController,
              decoration:
                  const InputDecoration(hintText: 'güncelleme içeriğini girin'),
            ),
            TextField(
              controller: youtubeUrlController,
              decoration: const InputDecoration(hintText: 'youtubeUrl Girin'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('İptal')),
          TextButton(
            onPressed: () async {
              http.Response? response = await App.apiService.updateEdit(
                id: existingUpdate.id,
                name: nameController.text,
                title: titleController.text,
                text: textController.text,
                youtubeUrl: youtubeUrlController.text,
              );

              if (response != null &&
                  (response.statusCode == 200 || response.statusCode == 204)) {
                Get.back();
                fetchupdateList();
                Get.snackbar('Başarılı', 'güncelleme notu başarıyla güncellendi!');
              } else {
                log('Hata: ${response?.statusCode}');
                log('Hata: ${response?.body}');
                Get.snackbar('Hata', 'güncelleme notu güncellenemedi!');
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

    fetchupdateList();
  }

  fetchupdateList() async {
    http.Response? response =
        await App.apiService.updateListToPanel(page: pagecount.value);

    if (response != null && response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      updateList.value = [];
      for (var element in responseData['data']) {
        updateList.value!.add(
          Update(
            name: element['name'],
            id: element['id'],
            youtube: element['youtubeUrl'],
          ),
        );
      }
      int totalCount = responseData['totalCount'];
      maxPagecount.value =
          (totalCount % 10 == 0) ? (totalCount ~/ 10) : (totalCount ~/ 10) + 1;
      updateList.refresh();
    }
  }
}

class Update {
  int id;
  String name;
  String youtube
  ;

  Update({
    required this.id,
    required this.name,
    required this.youtube,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'youtube': youtube,
    };
  }

  factory Update.fromJson(Map<String, dynamic> json) {
    return Update(
      id: json['id'] as int,
      name: json['name'] as String,
      youtube: json['youtube'] as String,
    );
  }
}
