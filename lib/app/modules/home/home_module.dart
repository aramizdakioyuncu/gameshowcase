import 'package:gameshowcase/app/modules/home/bindings/home_binding.dart';
import 'package:gameshowcase/app/modules/home/views/home_view.dart';
import 'package:get/get.dart';

class HomeModule {
  static const route = '/home';

  static final List<GetPage> routes = [
    GetPage(
      name: route,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
