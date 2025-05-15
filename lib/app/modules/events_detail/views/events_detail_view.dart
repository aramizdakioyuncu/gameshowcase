import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:gameshowcase/app/modules/events_detail/controllers/events_detail_controller.dart';
import 'package:gameshowcase/app/widgets/appbar_widget.dart';
import 'package:gameshowcase/app/widgets/menu_widget.dart';
import 'package:get/get.dart';

class EventsDetailView extends StatelessWidget {
  const EventsDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EventsDetailController());

    return Scaffold(
      appBar: AppbarWidget.appbar1(),
      body: Stack(
        children: [
          Image.asset(
            'wallpapers/login.gif',
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
                Obx(
                  () => controller.eventsDetail.value == null
                      ? CupertinoActivityIndicator()
                      : Column(
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  'http://185.93.68.107/api/Documents/cd071d3d-b85e-4a4e-bf89-f411297b89d5/${controller.eventsDetail.value?.bannerId}',
                              height: 500,
                              width: 500,
                              fit: BoxFit.cover,
                            ),
                            Text(
                              controller.eventsDetail.value!.title,
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.white54,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              controller.eventsDetail.value!.text,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(136, 255, 255, 255),
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
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
