import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gameshowcase/app/modules/events/controllers/event_controller.dart';
import 'package:gameshowcase/app/widgets/appbar_widget.dart';
import 'package:gameshowcase/app/widgets/menu_widget.dart';
import 'package:get/get.dart';

class EventView extends StatelessWidget {
  const EventView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EventsController());

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
                Padding(
                  padding: const EdgeInsets.all(100.0),
                  child: Container(
                    height: 900,
                    width: Get.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/etkinlikler_arkaplan.png'),
                      ),
                    ),
                  ),
                ),
                Text(
                  'ETKİNLİKLER',
                  style: TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                          blurRadius: 10,
                          color: const Color.fromARGB(255, 0, 0, 0),
                          offset: Offset(0, 0)),
                      Shadow(
                          blurRadius: 30,
                          color: const Color.fromARGB(255, 67, 159, 104),
                          offset: Offset(3, 3)),
                    ],
                  ),
                ),
                Obx(
                  () => controller.eventsList.value == null
                      ? Center(
                          child: CupertinoActivityIndicator(),
                        )
                      : Column(
                          children: List.generate(
                            controller.eventsList.value!.length,
                            (index) {
                              FetchEvents eventsItem =
                                  controller.eventsList.value![index];

                              return Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: InkWell(
                                  onTap: () => Get.toNamed(
                                      '/EventsDetail/${eventsItem.id}'),
                                  child: Container(
                                    color: Colors.black,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl:
                                              'http://185.93.68.107/api/Documents/cd071d3d-b85e-4a4e-bf89-f411297b89d5/${eventsItem.bannerId}',
                                          height: 280,
                                          width: 500,
                                          fit: BoxFit.cover,
                                        ),
                                        Expanded(
                                            child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                eventsItem.title,
                                                style: TextStyle(fontSize: 30),
                                              ),
                                              Text(eventsItem.createdDate,
                                                  style:
                                                      TextStyle(fontSize: 10))
                                            ],
                                          ),
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
