import 'package:gameshowcase/app/modules/addaccount/addaccount_module.dart';
import 'package:gameshowcase/app/modules/home/home_module.dart';
import 'package:gameshowcase/app/modules/login/login_module.dart';

class AppPages {
  static var initial = HomeModule.route;
  static final routes = [
    ...HomeModule.routes,
    ...LoginModule.routes,
    ...AddaccountModule.routes,
  ];
}
