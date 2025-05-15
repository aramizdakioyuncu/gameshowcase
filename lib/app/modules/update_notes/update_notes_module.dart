
import 'package:gameshowcase/app/modules/update_notes/views/update_notes_view.dart';
import 'package:get/get.dart';

class UpdateModule {
  static const route = '/update';

  static final List<GetPage> routes = [
    GetPage(
      name: route,
      page: () => const UpdateView(),
    ),
  ];
}
