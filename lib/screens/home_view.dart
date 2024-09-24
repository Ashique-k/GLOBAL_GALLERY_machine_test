import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Global Gallery'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: controller.galleryItems.length,
            itemBuilder: (context, index) {
              final item = controller.galleryItems[index];
              return ListTile(
                title: Text(item.name),
                subtitle: Text('UID: ${item.uid}, Type: ${controller.getDocTypeString(item.docType)}'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Get.snackbar('Item Tapped','URL: ${item.url}');
                },
              );
            },
          );
        }
      }),
    );
  }
}