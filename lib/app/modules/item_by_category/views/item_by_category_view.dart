import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jualin/utils/widgets/item_card.dart';
import '../../../themes/colors.dart';
import '../controllers/item_by_category_controller.dart';

class ItemByCategoryView extends GetView<ItemByCategoryController> {
  const ItemByCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final category = Get.arguments?['category'] ?? 'Kategori';

    return Scaffold(
      backgroundColor: neutral10,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          category,
          style: TextStyle(
            color: neutral10,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: neutral10),
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }
          if (controller.items.isEmpty) {
            return Center(
              child: Text(
                'No items found in this category',
                style: TextStyle(
                  color: neutral70,
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
                  //TODO: implement detailedItem navigation
                },
              );
            },
          );
        },
      ),
    );
  }
}
