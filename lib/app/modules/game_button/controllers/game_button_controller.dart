import 'package:get/get.dart';

class GameButtonController extends GetxController {
  var counter = 0.obs;

  void incrementCounter() {
    counter.value++;
  }
}
