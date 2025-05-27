import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gameshowcase/app/modules/news/controllers/news_controller.dart';
import 'package:gameshowcase/app/widgets/appbar_widget.dart';
import 'package:gameshowcase/app/widgets/menu_widget.dart';
import 'package:get/get.dart';

class NewsView extends StatelessWidget {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NewsController());

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
                Container(
                  height: 900,
                  width: Get.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/haberler1arka.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  'HABERLER',
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
                  () => controller.newsList.value == null
                      ? Center(
                          child: CupertinoActivityIndicator(),
                        )
                      : Column(
                          children: List.generate(
                            controller.newsList.value!.length,
                            (index) {
                              FetchNews newsItem =
                                  controller.newsList.value![index];

                              return Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: InkWell(
                                  onTap: () =>
                                      Get.toNamed('/NewsDetail/${newsItem.id}'),
                                  child: Container(
                                    color: Colors.black,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl:
                                              'http://185.93.68.107/api/Documents/cd071d3d-b85e-4a4e-bf89-f411297b89d5/${newsItem.bannerId}',
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
                                                newsItem.title,
                                                style: TextStyle(fontSize: 30),
                                              ),
                                              Text(newsItem.createdDate,
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
