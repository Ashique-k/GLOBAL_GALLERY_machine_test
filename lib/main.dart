import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_gallery_app/screens/app_pages.dart';

void main() {

  runApp(
    GetMaterialApp(
      title: "Global Gallery App",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}



