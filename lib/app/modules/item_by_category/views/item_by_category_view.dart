import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jualin/app/routes/app_pages.dart';
import 'package:jualin/widgets/item_card.dart';
import '../../../themes/colors.dart';
import '../controllers/item_by_category_controller.dart';

class ItemByCategoryView extends GetView<ItemByCategoryController> {
  const ItemByCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final category = Get.arguments?['category'] ?? 'Kategori';

    return Scaffold(
      backgroundColor: AppColors.neutral10,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          category,
          style: TextStyle(
            color: AppColors.neutral10,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.neutral10),
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }
          if (controller.items.isEmpty) {
            return Center(
              child: Text(
                'No items found in this category',
                style: TextStyle(
                  color: AppColors.neutral70,
                  fontSize: 16,
                ),
              ),
            );
          }
          return GridView.builder(
            padding: EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: controller.items.length,
            itemBuilder: (context, index) {
              final item = controller.items[index];
              return ItemCard(
                item: item,
                onTap: () {
                  Get.toNamed(
                    Routes.DETAILED_ITEM,
                    arguments: {
                      'item': item,
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
