import 'package:get/get.dart';

class MediaController extends GetxController {
  var counter = 0.obs;

  void incrementCounter() {
    counter.value++;
  }
}
