import 'dart:convert';
import 'dart:developer';

import 'package:gameshowcase/app/services/app.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NewsDetailController extends GetxController {
  var counter = 0.obs;

  Rxn<FetchNews> newsDetail = Rxn<FetchNews>();

  @override
  void onInit() {
    if (Get.parameters['id'] != null) {
      log('ID: ${Get.parameters['id']}');
      fetchnewsDetail(int.parse(Get.parameters['id'].toString()));
    } else {
      log('ID is null');
    }

    super.onInit();
  }

  void incrementCounter() {
    counter.value++;
  }

  fetchnewsDetail(int id) async {
    http.Response? response = await App.apiService.newsDetail(id: id);

    if (response != null && response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      newsDetail.value = FetchNews(
        id: responseData['id'],
        title: responseData['title'],
        bannerId: responseData['bannerId'],
        text: responseData['text'],
      );
    }
  }
}

class FetchNews {
  int id;
  String title;
  String text;
  int? bannerId;

  FetchNews({
    required this.id,
    required this.title,
    required this.text,
    required this.bannerId,
  });
}
