import 'package:gameshowcase/app/modules/admin_panel/admin_update_notes/views/updates_view.dart';
import 'package:get/get.dart';

class AdminUpdateModule {
  static const route = '/adminupdate';

  static final List<GetPage> routes = [
    GetPage(
      name: route,
      page: () => const AdminUpdateView(),
    ),
  ];
}
