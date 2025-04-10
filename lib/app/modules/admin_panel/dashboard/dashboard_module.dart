import 'package:gameshowcase/app/modules/admin_panel/dashboard/views/dashboard_view.dart';
import 'package:get/get.dart';

class DashboardModule {
  static const route = '/dashboard';

  static final List<GetPage> routes = [
    GetPage(
      name: route,
      page: () => const DashboardView(),
    ),
  ];
}
