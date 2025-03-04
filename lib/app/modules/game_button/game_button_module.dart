import 'package:gameshowcase/app/modules/game_button/views/game_button_view.dart';
import 'package:get/get.dart';

class GameButtonModule {
  static const route = '/gamebutton';

  static final List<GetPage> routes = [
    GetPage(
      name: route,
      page: () => const GameButtonView(),
    ),
  ];
}
