import 'package:gameshowcase/app/modules/admin_panel/admin_update_notes/views/updates_view.dart' show AdminUpdatesView;
import 'package:get/get.dart';

class AdminUpdatesModule {
  static const route = '/adminupdates';

  static final List<GetPage> routes = [
    GetPage(
      name: route,
      page: () => const AdminUpdatesView(),
    ),
  ];
}
