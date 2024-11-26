import 'package:gameshowcase/app/modules/addAccount/views/addAccount_view.dart';
import 'package:get/get.dart';

class AddaccountModule {
  static const route = '/addAccount';

  static final List<GetPage> routes = [
    GetPage(
      name: route,
      page: () => const AddaccountView(),
    ),
  ];
}
