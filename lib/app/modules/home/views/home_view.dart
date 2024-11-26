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
        toolbarHeight: 104.0,
        title: Image.asset(
          'images/logo.png',
          fit: BoxFit.contain,
          height: 50,
        ),
        centerTitle: true,
        actions: [
          ElevatedButton(
            onPressed: () {},
            child: const Row(
              children: [
                Icon(Icons.blur_circular),
                SizedBox(width: 5),
                Text('turkce'),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14.0),
            child: VerticalDivider(),
          ),
          ElevatedButton(
            onPressed: () {
              Get.toNamed("login");
            },
            child: const Row(
              children: [
                Icon(Icons.person),
                SizedBox(width: 5),
                Text('oturum ac'),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Padding(
              padding: EdgeInsets.all(42.0),
              child: Text('simdi oyna'),
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.black38,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'oyun',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'oyun',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'oyun',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'oyun',
                    ),
                  ),
                ),
              ],
            ),
          ),
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
            icon: const Icon(
              Icons.dark_mode,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
