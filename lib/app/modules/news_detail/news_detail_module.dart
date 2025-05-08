import 'package:gameshowcase/app/modules/news_detail/views/news_detail_view.dart';
import 'package:get/get.dart';

class NewsDetailModule {
  static const route = '/NewsDetail';

  static final List<GetPage> routes = [
    GetPage(
      name: '/NewsDetail/:id',
      page: () => const NewsDetailView(),
    ),
  ];
}
