import 'dart:convert';

import 'package:gameshowcase/app/services/app.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EventsController extends GetxController {
  var pagecount = 1.obs;
  var eventsList = Rxn<List<FetchEvents>>();
  var maxPagecount = 1.obs;
  @override
  void onInit() {
    fetcheventsList();
    super.onInit();
  }

  fetcheventsList() async {
    http.Response? response =
        await App.apiService.eventList(page: pagecount.value);

    if (response != null && response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      eventsList.value = [];
      for (var element in responseData['data']) {
        eventsList.value!.add(
          FetchEvents(
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
      eventsList.refresh();
    }
  }
}

class FetchEvents {
  int id;
  String title;
  String createdDate;
  String? youtubeUrl;
  int? bannerId;

  FetchEvents({
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

  factory FetchEvents.fromJson(Map<String, dynamic> json) {
    return FetchEvents(
      id: json['id'] as int,
      title: json['title'] as String,
      createdDate: json['createdDate'] as String,
      youtubeUrl: json['youtubeUrl'] as String,
      bannerId: json['bannerId'] as int,
    );
  }
}
