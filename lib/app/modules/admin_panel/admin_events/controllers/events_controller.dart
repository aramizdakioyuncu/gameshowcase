import 'package:armoyu_services/armoyu_services.dart';
import 'package:flutter/material.dart';
import 'package:gameshowcase/app/services/app.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AdminEventsController extends GetxController {
  Rxn<List<Events>> eventsList = Rxn();
  var pagecount = 1.obs;
  var maxPagecount = 1.obs;

  Future<void> removeEvents(int index) async {
    http.Response? response =
        await App.apiService.eventsRemove(id: eventsList.value![index].id);
    if (response != null && response.statusCode == 204) {
      eventsList.value!.removeAt(index);

      eventsList.refresh();
      Get.back();
    } else {
      log('Hata: ${response?.statusCode}');
      log('Hata: ${response?.body}');
      Get.snackbar('Hata', 'etkinlik silinmedi!');
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

  void showAddEventsDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController titleController = TextEditingController();
    TextEditingController textController = TextEditingController();
    TextEditingController youtubeUrlController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text('Yeni Etkinlik Ekle'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration:
                  const InputDecoration(hintText: 'Etkinlik adını Girin'),
            ),
            TextField(
              controller: titleController,
              decoration:
                  const InputDecoration(hintText: 'Etkinlik Başlığını Girin'),
            ),
            TextField(
              controller: textController,
              decoration:
                  const InputDecoration(hintText: 'Etkinlik içeriğini Girin'),
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

              http.Response? response = await App.apiService.eventsAdd(
                name: nameController.text,
                title: titleController.text,
                text: textController.text,
                banner: avatarFile!,
                youtubeUrl: youtubeUrlController.text,
              );

              if (response != null && response.statusCode == 201) {
                Get.back();
                fetcheventsList();
              } else {
                log('Hata: ${response?.statusCode}');
                log('Hata: ${response?.body}');
                Get.snackbar('Hata', 'Etkinlik eklenemedi!');
              }
            },
            child: const Text('Ekle'),
          ),
        ],
      ),
    );
  }

  void showEditEventsDialog(Events existingEvents) async {
    // Haberi API'den çek
    http.Response? response =
        await App.apiService.eventsDetail(id: existingEvents.id);
    String title = '';
    String text = '';

    if (response != null && response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      title = responseData['title'] ?? '';
      text = responseData['text'] ?? '';
    }

    TextEditingController nameController =
        TextEditingController(text: existingEvents.name);
    TextEditingController titleController = TextEditingController(text: title);
    TextEditingController textController = TextEditingController(text: text);
    XFile? newBannerFile;

    Get.dialog(
      AlertDialog(
        title: const Text('Etkinlik Düzenle'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration:
                  const InputDecoration(hintText: 'Etkinlik adını girin'),
            ),
            TextField(
              controller: titleController,
              decoration:
                  const InputDecoration(hintText: 'Etkinlik başlığını girin'),
            ),
            TextField(
              controller: textController,
              decoration:
                  const InputDecoration(hintText: 'Etkinlik içeriğini girin'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('İptal')),
          TextButton(
            onPressed: () async {
              http.Response? response = await App.apiService.eventsEdit(
                id: existingEvents.id,
                name: nameController.text,
                title: titleController.text,
                text: textController.text,
              );

              if (response != null &&
                  (response.statusCode == 200 || response.statusCode == 204)) {
                Get.back();
                fetcheventsList();
                Get.snackbar('Başarılı', 'Etkinlik başarıyla güncellendi!');
              } else {
                log('Hata: ${response?.statusCode}');
                log('Hata: ${response?.body}');
                Get.snackbar('Hata', 'Etkinlik güncellenemedi!');
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

    fetcheventsList();
  }

  fetcheventsList() async {
    http.Response? response =
        await App.apiService.eventsListToPanel(page: pagecount.value);

    if (response != null && response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      eventsList.value = [];
      for (var element in responseData['data']) {
        eventsList.value!.add(
          Events(
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
      eventsList.refresh();
    }
  }
}

class Events {
  int id;
  String name;
  String title;
  String text;

  Events({
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

  factory Events.fromJson(Map<String, dynamic> json) {
    return Events(
      id: json['id'] as int,
      name: json['name'] as String,
      title: json['title']?['tr'] as String? ?? '',
      text: json['text']?['tr'] as String? ?? '',
    );
  }
}
