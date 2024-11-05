import 'package:flutter/material.dart';
import 'package:gameshowcase/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("title"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("hello".tr),
            Text("language".tr),
            Text(
              'You have pushed the button this many times:'.tr,
            ),
            Obx(
              () => Text(
                '${controller.counter.value}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            IconButton(
              onPressed: () {
                Get.changeThemeMode(
                    Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
              },
              icon: Icon(
                Icons.dark_mode,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                controller.incrementCounter();

                // Get.toNamed("/game-info");
                Get.offAndToNamed("/game-info");
              },
              child: const Text("Diğer Sayfaya Geç"),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
