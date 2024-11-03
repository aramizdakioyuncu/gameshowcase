import 'package:gameshowcase/app/modules/home/views/home_view.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeView>(() => const HomeView());
  }
}
