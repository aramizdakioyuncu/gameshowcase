import 'package:get/get.dart';

class NewsController extends GetxController {
  var counter = 0.obs;

  void incrementCounter() {
    counter.value++;
  }
}
