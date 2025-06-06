import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jualin/app/routes/app_pages.dart';
import 'package:jualin/app/themes/colors.dart';

import '../controllers/sell_items_controller.dart';

class SellItemsView extends GetView<SellItemsController> {
  const SellItemsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'My Transactions',
          style: TextStyle(
            color: AppColors.neutral10,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.MY_ACCOUNT);
            },
            icon: Icon(
              Icons.person_outline,
              color: AppColors.neutral10,
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SellItemsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
