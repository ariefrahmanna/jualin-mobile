import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
              return Card(
                color: neutral10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    // TODO: Get.toNamed to item detail page
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.network(
                            item['image_url'] ?? '',
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: neutral10,
                                child: Icon(
                                  Icons.broken_image,
                                  color: neutral70,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: text,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Rp ${item['price']}',
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
