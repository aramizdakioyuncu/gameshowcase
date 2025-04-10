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
      body: Stack(
        children: [
          Obx(() {
            return ListView.builder(
              padding: const EdgeInsets.only(
                top: 80,
              ), // Butonun üstte olması için
              itemCount: controller.newsList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(controller.newsList[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      controller.removeNews(index);
                    },
                  ),
                );
              },
            );
          }),

          // Üste ortalanmış ekleme butonu
          Positioned(
            top: 10,
            left: 0,
            right: 0,
            child: Center(
              child: FloatingActionButton(
                onPressed: () => controller.showAddNewsDialog(),
                child: const Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
