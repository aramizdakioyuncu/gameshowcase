import 'package:flutter/material.dart';
import 'package:gameshowcase/app/modules/maps/maps_controller/maps_controller.dart';
import 'package:gameshowcase/app/widgets/appbar_widget.dart';
import 'package:gameshowcase/app/widgets/menu_widget.dart';
import 'package:get/get.dart';

class MapsView extends StatelessWidget {
  const MapsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MapsController());

    return Scaffold(
      appBar: AppbarWidget.appbar1(),
      body: Stack(
        children: [
          Image.asset(
            'assets/wallpapers/login.gif',
            fit: BoxFit.cover,
            height: Get.height,
            width: Get.width,
          ),
          Container(
            height: Get.height,
            width: Get.width,
            color: Colors.black.withOpacity(0.75), // karanlık efekti
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                MenuWidget.menu(),
                ...List.generate(
                  1,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        color: Colors.black87,
                        height: 500,
                        width: Get.width,
                        child: Column(
                          children: [
                            Text('HARİTA 1'),
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        'assets/images/haritalar1.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        'assets/images/haritalar2.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        'assets/images/haritalar3.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        'assets/images/haritalar4.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
