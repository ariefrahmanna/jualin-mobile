import 'package:get/get.dart';

import '../controllers/detailed_item_controller.dart';

class DetailedItemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailedItemController>(
      () => DetailedItemController(),
    );
  }
}
