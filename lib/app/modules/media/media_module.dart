import 'package:gameshowcase/app/modules/media/views/media_view.dart';
import 'package:get/get.dart';

class MediaModule {
  static const route = '/media';

  static final List<GetPage> routes = [
    GetPage(
      name: route,
      page: () => const MediaView(),
    ),
  ];
}
