import 'package:get/get.dart';

import '../controllers/item_by_category_controller.dart';

class ItemByCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ItemByCategoryController>(
      () => ItemByCategoryController(),
    );
  }
}
