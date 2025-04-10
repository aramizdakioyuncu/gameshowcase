import 'package:gameshowcase/app/modules/admin_panel/admin_news/views/news_view.dart';
import 'package:get/get.dart';

class AdminNewsModule {
  static const route = '/adminnews';

  static final List<GetPage> routes = [
    GetPage(
      name: route,
      page: () => const AdminNewsView(),
    ),
  ];
}
