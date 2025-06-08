import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gameshowcase/app/modules/admin_panel/admin_events/controllers/events_controller.dart';
import 'package:get/get.dart';

class AdminEventsView extends StatelessWidget {
  const AdminEventsView({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminEventsController controller = Get.put(AdminEventsController());

    return Scaffold(
      appBar: AppBar(title: const Text('Etkinlikler')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: FloatingActionButton(
                onPressed: () => controller.showAddEventsDialog(),
                child: const Icon(Icons.add),
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => controller.eventsList.value == null
                  ? Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(
                        top: 80,
                      ), // Butonun üstte olması için
                      itemCount: controller.eventsList.value!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Text((index +
                                  1 +
                                  ((controller.pagecount.value - 1) * 10))
                              .toString()),
                          title: Text(controller.eventsList.value![index].name),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon:
                                    const Icon(Icons.edit), // ✏️ Kalem simgesi
                                onPressed: () {
                                  controller.showEditEventsDialog(
                                      controller.eventsList.value![index]);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  controller.removeEvents(index);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (controller.pagecount.value - 1 < 1) {
                      return;
                    }
                    controller.pagecount.value--;

                    controller.fetcheventsList();
                  },
                  child: const Text("Geri"),
                ),
                const SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(
                    () => Text(
                      (controller.pagecount.value).toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (controller.pagecount.value >=
                        controller.maxPagecount.value) {
                      return;
                    }
                    controller.pagecount.value++;
                    controller.fetcheventsList();
                  },
                  child: const Text("İleri"),
                ),
              ],
            ),
          ),

          // Üste ortalanmış ekleme butonu
        ],
      ),
    );
  }
}
