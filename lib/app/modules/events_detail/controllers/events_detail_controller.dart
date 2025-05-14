import 'dart:convert';
import 'dart:developer';

import 'package:gameshowcase/app/services/app.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EventsDetailController extends GetxController {
  var counter = 0.obs;

  Rxn<FetchEvents> eventsDetail = Rxn<FetchEvents>();

  @override
  void onInit() {
    if (Get.parameters['eventid'] != null) {
      log('ID: ${Get.parameters['eventid']}');
      fetchEventsDetail(int.parse(Get.parameters['eventid'].toString()));
    } else {
      log('ID is null');
    }

    super.onInit();
  }

  void incrementCounter() {
    counter.value++;
  }

  fetchEventsDetail(int id) async {
    http.Response? response = await App.apiService.eventsDetail(id: id);

    if (response != null && response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      eventsDetail.value = FetchEvents(
        id: responseData['id'],
        title: responseData['title'],
        bannerId: responseData['bannerId'],
        text: responseData['text'],
      );
    }
  }
}

class FetchEvents {
  int id;
  String title;
  String text;
  int? bannerId;

  FetchEvents({
    required this.id,
    required this.title,
    required this.text,
    required this.bannerId,
  });
}
