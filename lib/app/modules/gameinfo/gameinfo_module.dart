import 'package:gameshowcase/app/modules/gameinfo/bindings/gameinfo_binding.dart';
import 'package:gameshowcase/app/modules/gameinfo/views/gameinfo_view.dart';
import 'package:get/get.dart';

class GameinfoModule {
  static const route = '/game-info';

  static final List<GetPage> routes = [
    GetPage(
      name: route,
      page: () => const GameinfoView(),
      binding: GameinfoBinding(),
    ),
  ];
}
