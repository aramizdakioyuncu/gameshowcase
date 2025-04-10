import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/updates_controller.dart';

class AdminUpdatesView extends StatelessWidget {
  const AdminUpdatesView({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminUpdatesController controller = Get.put(AdminUpdatesController());

    return Scaffold(
      appBar: AppBar(title: const Text('Güncelleme Notları')),
      body: Stack(
        children: [
          Obx(() {
            return ListView.builder(
              padding: const EdgeInsets.only(top: 80),
              itemCount: controller.updatesList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(controller.updatesList[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      controller.removeUpdate(index);
                    },
                  ),
                );
              },
            );
          }),

          Positioned(
            top: 10,
            left: 0,
            right: 0,
            child: Center(
              child: FloatingActionButton(
                onPressed: () => controller.showAddUpdateDialog(),
                child: const Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
