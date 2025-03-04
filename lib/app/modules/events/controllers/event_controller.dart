import 'package:get/get.dart';

class EventController extends GetxController {
  var counter = 0.obs;

  void incrementCounter() {
    counter.value++;
  }
}
