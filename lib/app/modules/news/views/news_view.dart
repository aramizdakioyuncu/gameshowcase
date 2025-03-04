import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gameshowcase/app/modules/news/controllers/news_controller.dart';
import 'package:gameshowcase/app/widgets/appbar_widget.dart';
import 'package:gameshowcase/app/widgets/menu_widget.dart';
import 'package:get/get.dart';

class NewsView extends StatelessWidget {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NewsController());

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
              child: Column(children: [
                MenuWidget.menu(),
                const Text(
                  'HABERLER',
                  style: TextStyle(
                      fontSize: 50, color: Color.fromARGB(255, 221, 78, 7)),
                ),
                ...List.generate(
                  5,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        color: Colors.black,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  'https://wstatic-prod-boc.krafton.com/common/content/news/20241228/05ClqwbA_thumb.jpg',
                              height: 280,
                              width: 500,
                              fit: BoxFit.cover,
                            ),
                            const Expanded(
                                child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'BAHAR 2024, YENİ YIL HEDİYESİYLE GERİ DÖNÜYOR!',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  Text(
                                      'BAHAR 2024, YENİ YIL HEDİYESİYLE GERİ DÖNÜYOR!',
                                      style: TextStyle(fontSize: 10))
                                ],
                              ),
                            ))
                          ],
                        ),
                      ),
                    );
                  },
                )
              ]),
            ),
          ],
        ));
  }
}
