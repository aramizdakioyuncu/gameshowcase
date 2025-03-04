import 'package:gameshowcase/app/modules/news/views/news_view.dart';
import 'package:get/get.dart';

class NewsModule {
  static const route = '/news';

  static final List<GetPage> routes = [
    GetPage(
      name: route,
      page: () => const NewsView(),
    ),
  ];
}
