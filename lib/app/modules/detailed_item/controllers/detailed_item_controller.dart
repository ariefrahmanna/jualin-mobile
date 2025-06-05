import 'package:get/get.dart';

class DetailedItemController extends GetxController {
  var isWishlisted = false.obs;

  late String title;
  late String price;
  late String description;
  late String imagePath;

  void toggleWishlist() {
    isWishlisted.value = !isWishlisted.value;
  }

  @override
  void onInit() {
    final args = Get.arguments;
    title = args['title'] ?? '';
    price = args['price'] ?? '';
    description = args['description'] ?? '';
    imagePath = args['imagePath'] ?? '';
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
