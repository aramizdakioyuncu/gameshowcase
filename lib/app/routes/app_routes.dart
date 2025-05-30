import 'package:gameshowcase/app/modules/addaccount/addaccount_module.dart';
import 'package:gameshowcase/app/modules/admin_panel/admin_events/admin_event_module.dart';
import 'package:gameshowcase/app/modules/admin_panel/admin_news/admin_news_module.dart';
import 'package:gameshowcase/app/modules/admin_panel/admin_update_notes/admin_updates_notes_module.dart';
import 'package:gameshowcase/app/modules/admin_panel/dashboard/dashboard_module.dart';
import 'package:gameshowcase/app/modules/events/event_module.dart';
import 'package:gameshowcase/app/modules/game_button/game_button_module.dart';
import 'package:gameshowcase/app/modules/help/help_module.dart';
import 'package:gameshowcase/app/modules/home/home_module.dart';
import 'package:gameshowcase/app/modules/login/login_module.dart';
import 'package:gameshowcase/app/modules/maps/maps_module.dart';
import 'package:gameshowcase/app/modules/media/media_module.dart';
import 'package:gameshowcase/app/modules/news/news_module.dart';
import 'package:gameshowcase/app/modules/news_detail/news_detail_module.dart';

class AppPages {
  static var initial = HomeModule.route;
  static final routes = [
    ...HomeModule.routes,
    ...LoginModule.routes,
    ...AddaccountModule.routes,
    ...GameButtonModule.routes,
    ...NewsModule.routes,
    ...MediaModule.routes,
    ...EventModule.routes,
    ...HelpModule.routes,
    ...MapsModule.routes,
    ...AdminEventModule.routes,
    ...AdminNewsModule.routes,
    ...AdminUpdatesModule.routes,
    ...DashboardModule.routes,
    ...NewsDetailModule.routes,
  ];
}
