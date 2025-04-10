import 'package:get/get.dart';

class DashboardController extends GetxController {
  var selectedPage = "dashboard".obs; 

  void changePage(String page) {
    selectedPage.value = page;
  }
}
