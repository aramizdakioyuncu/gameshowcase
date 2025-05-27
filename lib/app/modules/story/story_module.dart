import 'package:gameshowcase/app/modules/story/views/story_view.dart';
import 'package:get/get.dart';

class StoryModule {
  static const route = '/story';

  static final List<GetPage> routes = [
    GetPage(
      name: route,
      page: () => const StoryView(),
    ),
  ];
}
