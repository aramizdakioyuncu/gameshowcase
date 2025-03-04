import 'package:gameshowcase/app/modules/help/views/help_view.dart';
import 'package:get/get.dart';

class HelpModule {
  static const route = '/help';

  static final List<GetPage> routes = [
    GetPage(
      name: route,
      page: () => const HelpView(),
    ),
  ];
}
