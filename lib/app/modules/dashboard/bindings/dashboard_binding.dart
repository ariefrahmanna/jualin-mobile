import 'package:get/get.dart';
import 'package:jualin/app/modules/home/controllers/home_controller.dart';
import 'package:jualin/app/modules/sell_items/controllers/sell_items_controller.dart';
import 'package:jualin/app/modules/transactions/controllers/transactions_controller.dart';

import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<TransactionsController>(
      () => TransactionsController(),
    );
    Get.lazyPut<SellItemsController>(
      () => SellItemsController(),
    );
  }
}
