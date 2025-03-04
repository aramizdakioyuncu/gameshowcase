import 'package:get/get.dart';

class HelpController extends GetxController {
  var counter = 0.obs;

  void incrementCounter() {
    counter.value++;
  }
}
