import 'package:gameshowcase/app/modules/addaccount/addaccount_module.dart';
import 'package:gameshowcase/app/modules/admin_panel/admin_events/admin_event_module.dart';
import 'package:gameshowcase/app/modules/admin_panel/admin_news/admin_news_module.dart';
import 'package:gameshowcase/app/modules/admin_panel/admin_update_notes/admin_updates_notes_module.dart';
import 'package:gameshowcase/app/modules/admin_panel/dashboard/dashboard_module.dart';
import 'package:gameshowcase/app/modules/events/event_module.dart';
import 'package:gameshowcase/app/modules/events_detail/events_detail_module.dart';
import 'package:gameshowcase/app/modules/story/story_module.dart';
import 'package:gameshowcase/app/modules/home/home_module.dart';
import 'package:gameshowcase/app/modules/login/login_module.dart';
import 'package:gameshowcase/app/modules/maps/maps_module.dart';
import 'package:gameshowcase/app/modules/media/media_module.dart';
import 'package:gameshowcase/app/modules/news/news_module.dart';
import 'package:gameshowcase/app/modules/news_detail/news_detail_module.dart';
import 'package:gameshowcase/app/modules/update_notes/update_notes_module.dart';

class AppPages {
  static var initial = HomeModule.route;
  static final routes = [
    ...HomeModule.routes,
    ...LoginModule.routes,
    ...AddaccountModule.routes,
    ...StoryModule.routes,
    ...NewsModule.routes,
    ...MediaModule.routes,
    ...EventModule.routes,
    ...MapsModule.routes,
    ...AdminEventModule.routes,
    ...AdminNewsModule.routes,
    ...AdminUpdateModule.routes,
    ...DashboardModule.routes,
    ...NewsDetailModule.routes,
    ...EventsDetailModule.routes,
    ...UpdateModule.routes,
  ];
}
