import 'package:gameshowcase/app/modules/events/views/event_view.dart';
import 'package:get/get.dart';

class EventModule {
  static const route = '/events';

  static final List<GetPage> routes = [
    GetPage(
      name: route,
      page: () => const EventView(),
    ),
  ];
}
