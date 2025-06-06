import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jualin/app/modules/home/views/home_view.dart';
import 'package:jualin/app/modules/sell_items/views/sell_items_view.dart';
import 'package:jualin/app/modules/transactions/views/transactions_view.dart';
import 'package:jualin/app/modules/wishlist/views/wishlist_view.dart';
import 'package:jualin/app/themes/colors.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  DashboardView({super.key});

  final List<Widget> pages = [
    HomeView(),
    WishlistView(),
    TransactionsView(),
    SellItemsView(),
  ];

  @override
  Widget build(BuildContext context) {
    // Ambil instance controller
    final controller = Get.find<DashboardController>();

    return Obx(() => Scaffold(
          body: IndexedStack(
            index: controller.selectedIndex.value,
            children: pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.selectedIndex.value,
            onTap: (index) {
              controller.changePage(index);
            },
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.neutral50,
            backgroundColor: AppColors.neutral10,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                label: 'Wishlist',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long_outlined),
                label: 'Transactions',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.sell_outlined),
                label: 'Sell Items',
              ),
            ],
          ),
        ));
  }
}
