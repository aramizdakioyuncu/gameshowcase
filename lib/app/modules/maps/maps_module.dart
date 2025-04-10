import 'package:gameshowcase/app/modules/maps/maps_views/maps_view.dart';
import 'package:get/get.dart';

class MapsModule {
  static const route = '/maps';

  static final List<GetPage> routes = [
    GetPage(
      name: route,
      page: () => const MapsView(),
    ),
  ];
}
