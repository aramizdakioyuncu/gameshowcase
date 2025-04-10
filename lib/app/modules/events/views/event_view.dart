import 'package:flutter/material.dart';
import 'package:gameshowcase/app/modules/events/controllers/event_controller.dart';
import 'package:gameshowcase/app/widgets/appbar_widget.dart';
import 'package:gameshowcase/app/widgets/menu_widget.dart';
import 'package:get/get.dart';

class EventView extends StatelessWidget {
  const EventView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EventController());

    return Scaffold(
      appBar: AppbarWidget.appbar1(),
      body: Stack(
        children: [
          Image.asset(
            'wallpapers/login.jpg',
            fit: BoxFit.cover,
            height: Get.height,
            width: Get.width,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                MenuWidget.menu(),
                Container(
                  height: 900,
                  width: Get.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage('assets/images/etkinlikler_arkaplan.webp'),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(19.0),
                        child: Text(
                          textAlign: TextAlign.center,
                          'ETKINLIKLER',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 50),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(100.0),
                        child: Container(
                          height: 300,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  'assets/images/siyah_arka_plan.jpg'),
                            ),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text('data'),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text('data'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(100.0),
                        child: Container(
                          height: 300,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  'assets/images/siyah_arka_plan.jpg'),
                            ),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text('data'),
                              ),
                              Expanded(flex: 1, child: Text('data')),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
