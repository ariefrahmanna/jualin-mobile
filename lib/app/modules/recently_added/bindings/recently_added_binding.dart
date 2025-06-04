import 'package:get/get.dart';

import '../controllers/recently_added_controller.dart';

class RecentlyAddedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecentlyAddedController>(
      () => RecentlyAddedController(),
    );
  }
}
