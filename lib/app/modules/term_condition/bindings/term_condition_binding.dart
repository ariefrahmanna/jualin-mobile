import 'package:get/get.dart';

import '../controllers/term_condition_controller.dart';

class TermConditionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TermConditionController>(
      () => TermConditionController(),
    );
  }
}
