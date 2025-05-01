import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/news_controller.dart';

class AdminNewsView extends StatelessWidget {
  const AdminNewsView({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminNewsController controller = Get.put(AdminNewsController());

    return Scaffold(
      appBar: AppBar(title: const Text('Haberler')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: FloatingActionButton(
                onPressed: () => controller.showAddNewsDialog(),
                child: const Icon(Icons.add),
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => controller.newsList.value == null
                  ? Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(
                        top: 80,
                      ), // Butonun üstte olması için
                      itemCount: controller.newsList.value!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Text((index +
                                  1 +
                                  ((controller.pagecount.value - 1) * 10))
                              .toString()),
                          title: Text(controller.newsList.value![index].name),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              controller.removeNews(index);
                            },
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

                    controller.fetchnewsList();
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
                    controller.fetchnewsList();
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
