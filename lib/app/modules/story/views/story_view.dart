import 'package:flutter/material.dart';
import 'package:gameshowcase/app/modules/story/controllers/story_controller.dart';
import 'package:gameshowcase/app/widgets/appbar_widget.dart';
import 'package:gameshowcase/app/widgets/menu_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class StoryView extends StatelessWidget {
  const StoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StoryController());

    return Scaffold(
      appBar: AppbarWidget.appbar1(),
      body: Stack(
        children: [
          // Arkaplan GIF
          Image.asset(
            'assets/wallpapers/login.gif',
            fit: BoxFit.cover,
            height: Get.height,
            width: Get.width,
          ),

          // Siyah şeffaf karanlık overlay
          Container(
            height: Get.height,
            width: Get.width,
            color: Colors.black.withOpacity(0.75),
          ),

          // Menü
          MenuWidget.menu(),

          // Fotoğraf gösterme alanı
          
          Center(
            child: Padding(
              padding: const EdgeInsets.all(60.0),
              child: Container(
                margin: const EdgeInsets.all(20),
                height: Get.height,
                width: Get.width,
                child: PageView.builder(
                  controller: controller.pageController,
                  onPageChanged: (index) =>
                      controller.currentIndex.value = index,
                  itemCount: controller.imagePaths.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        controller.imagePaths[index],
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // Sol buton
          Positioned(
            left: 20,
            top: Get.height / 2 - 24,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: controller.previousImage,
            ),
          ),

          // Sağ buton
          Positioned(
            right: 20,
            top: Get.height / 2 - 24,
            child: IconButton(
              icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
              onPressed: controller.nextImage,
            ),
          ),
        ],
      ),
    );
  }
}
