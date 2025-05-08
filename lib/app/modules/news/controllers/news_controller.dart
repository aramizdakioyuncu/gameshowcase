import 'dart:convert';

import 'package:gameshowcase/app/services/app.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NewsController extends GetxController {
  var pagecount = 1.obs;
  var newsList = Rxn<List<FetchNews>>();
  var maxPagecount = 1.obs;
  @override
  void onInit() {
    fetchnewsList();
    super.onInit();
  }

  fetchnewsList() async {
    http.Response? response =
        await App.apiService.newsList(page: pagecount.value);

    if (response != null && response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      newsList.value = [];
      for (var element in responseData['data']) {
        newsList.value!.add(
          FetchNews(
            id: element['id'],
            title: element['title'],
            bannerId: element['bannerId'],
            createdDate: element['createdDate'],
            youtubeUrl: element['youtubeUrl'],
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

class FetchNews {
  int id;
  String title;
  String createdDate;
  String? youtubeUrl;
  int? bannerId;

  FetchNews({
    required this.id,
    required this.title,
    required this.createdDate,
    this.youtubeUrl,
    required this.bannerId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': title,
      'createdDate': createdDate,
      'youtubeUrl': youtubeUrl,
      'bannerId': bannerId,
    };
  }

  factory FetchNews.fromJson(Map<String, dynamic> json) {
    return FetchNews(
      id: json['id'] as int,
      title: json['title'] as String,
      createdDate: json['createdDate'] as String,
      youtubeUrl: json['youtubeUrl'] as String,
      bannerId: json['bannerId'] as int,
    );
  }
}
