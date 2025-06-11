// ignore_for_file: unnecessary_overrides

import 'package:get/get.dart';
import 'package:jualin/app/modules/home/controllers/home_controller.dart';
import 'package:jualin/app/modules/sell_items/controllers/sell_items_controller.dart';
import 'package:jualin/app/modules/transactions/controllers/transactions_controller.dart';
import 'package:jualin/app/modules/wishlist/controllers/wishlist_controller.dart';

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;
  HomeController homeController = Get.put(HomeController());
  WishlistController wishlistController = Get.put(WishlistController());
  TransactionsController transactionsController =
      Get.put(TransactionsController());
  SellItemsController sellItemsController = Get.put(SellItemsController());

  void changePage(int index) {
    selectedIndex.value = index;
    switch (index) {
      case 0:
        homeController.fetchRecentlyAddedPreview();
        break;
      case 1:
        wishlistController.fetchWishlist();
        break;
      case 2:
        transactionsController.fetchTransactions();
        break;
      case 3:
        sellItemsController.fetchSellItems();
        break;
    }
  }

  void setIndexFromArguments(dynamic args) {
    if (args != null && args['index'] != null) {
      selectedIndex.value = args['index'];
    }
  }

  @override
  void onInit() {
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
