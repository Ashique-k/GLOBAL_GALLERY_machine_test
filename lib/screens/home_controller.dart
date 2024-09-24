import 'package:get/get.dart';

import 'api_provider.dart';
import 'gallery_item_model.dart';

class HomeController extends GetxController {
  final ApiProvider apiProvider = ApiProvider();
  final RxList<GalleryItem> galleryItems = <GalleryItem>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    fetchGalleryItems();
    super.onInit();
  }

  void fetchGalleryItems() async {
    try {
      isLoading(true);
      final items = await apiProvider.fetchGalleryItems();
      galleryItems.assignAll(items);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  String getDocTypeString(int docType) {
    switch (docType) {
      case 0:
        return 'Image';
      case 1:
        return 'Video';
      case 2:
        return 'PDF';
      case 3:
        return 'Audio';
      case 4:
        return 'Document';
      default:
        return 'Unknown';
    }
  }
}

