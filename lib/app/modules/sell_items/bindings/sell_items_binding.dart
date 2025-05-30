import 'package:get/get.dart';

import '../controllers/sell_items_controller.dart';

class SellItemsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellItemsController>(
      () => SellItemsController(),
    );
  }
}
