import 'package:gameshowcase/app/modules/gameinfo/views/gameinfo_view.dart';
import 'package:get/get.dart';

class GameinfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GameinfoView>(() => const GameinfoView());
  }
}
