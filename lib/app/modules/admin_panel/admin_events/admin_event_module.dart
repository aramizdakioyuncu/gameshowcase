import 'package:gameshowcase/app/modules/admin_panel/admin_events/views/events_view.dart';
import 'package:get/get.dart';

class AdminEventModule {
  static const route = '/adminevent';

  static final List<GetPage> routes = [
    GetPage(
      name: route,
      page: () => const AdminEventsView(),
    ),
  ];
}
