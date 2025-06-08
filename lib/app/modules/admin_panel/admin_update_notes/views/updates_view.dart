import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gameshowcase/app/modules/admin_panel/admin_update_notes/controllers/updates_controller.dart';
import 'package:get/get.dart';

class AdminUpdateView extends StatelessWidget {
  const AdminUpdateView({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminUpdateController controller = Get.put(AdminUpdateController());

    return Scaffold(
      appBar: AppBar(title: const Text('guncellemeler')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: FloatingActionButton(
                onPressed: () => controller.showAddUpdateDialog(),
                child: const Icon(Icons.add),
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => controller.updateList.value == null
                  ? Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(
                        top: 80,
                      ), // Butonun üstte olması için
                      itemCount: controller.updateList.value!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Text((index +
                                  1 +
                                  ((controller.pagecount.value - 1) * 10))
                              .toString()),
                          title: Text(controller.updateList.value![index].name),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon:
                                    const Icon(Icons.edit), // ✏️ Kalem simgesi
                                onPressed: () {
                                  controller.showEditUpdateDialog(
                                      controller.updateList.value![index]);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  controller.removeUpdate(index);
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

                    controller.fetchupdateList();
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
                    controller.fetchupdateList();
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
