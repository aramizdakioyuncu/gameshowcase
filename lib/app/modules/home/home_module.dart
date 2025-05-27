import 'package:gameshowcase/app/modules/home/views/home_view.dart';
import 'package:get/get.dart';

class HomeModule {
  static const route = '/';

  static final List<GetPage> routes = [
    GetPage(
      name: route,
      page: () => const HomeView(),
    ),
  ];
}
