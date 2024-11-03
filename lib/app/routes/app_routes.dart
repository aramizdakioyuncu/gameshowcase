import 'package:gameshowcase/app/modules/gameinfo/gameinfo_module.dart';
import 'package:gameshowcase/app/modules/home/home_module.dart';

class AppPages {
  static var initial = HomeModule.route;
  static final routes = [
    ...HomeModule.routes,
    ...GameinfoModule.routes,
  ];
}
