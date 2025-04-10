import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/events_controller.dart';

class AdminEventsView extends StatelessWidget {
  const AdminEventsView({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminEventsController controller = Get.put(AdminEventsController());

    return Scaffold(
      appBar: AppBar(title: const Text('Etkinlikler')),
      body: Stack(
        children: [
          Obx(() {
            return ListView.builder(
              padding: const EdgeInsets.only(top: 80),
              itemCount: controller.eventsList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(controller.eventsList[index]), 
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      controller.removeEvent(index); 
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
                onPressed: () => controller.showAddEventDialog(),
                child: const Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
