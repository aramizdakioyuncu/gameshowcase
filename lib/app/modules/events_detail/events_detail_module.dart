import 'package:gameshowcase/app/modules/events_detail/views/events_detail_view.dart';

import 'package:get/get.dart';

class EventsDetailModule {
  static const route = '/EventsDetail';

  static final List<GetPage> routes = [
    GetPage(
      name: '/EventsDetail/:eventid',
      page: () => const EventsDetailView(),
    ),
  ];
}
