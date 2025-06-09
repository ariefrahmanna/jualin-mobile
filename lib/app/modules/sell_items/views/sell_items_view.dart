import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jualin/app/routes/app_pages.dart';
import 'package:jualin/app/themes/colors.dart';
import 'package:jualin/utils/currency_formatter.dart';
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
          'My Items',
          style: TextStyle(
            color: AppColors.neutral10,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.MY_ACCOUNT),
            icon: const Icon(Icons.person_outline, color: AppColors.neutral10),
          ),
        ],
        centerTitle: true,
      ),
      body: Obx(() {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.pending,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Pending Items',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.background,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            controller.pendingItems.isEmpty
                ? const Text('No pending items.')
                : ListView.builder(
                    itemCount: controller.pendingItems.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = controller.pendingItems[index];
                      return sellItemCard(
                        item: item,
                        onTap: () {
                          Get.toNamed(
                            Routes.DETAILED_ITEM,
                            arguments: {'item': item},
                          );
                        },
                        onEdit: () {
                          Get.toNamed(
                            Routes.EDIT_ITEM,
                            arguments: {'item': item},
                          );
                        },
                      );
                    },
                  ),
            const SizedBox(height: 24),
            // Listed Items Section
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.success,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Listed Items',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.background,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            controller.listedItems.isEmpty
                ? const Text('No listed items.')
                : ListView.builder(
                    itemCount: controller.listedItems.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = controller.listedItems[index];
                      return sellItemCard(
                        item: item,
                        onTap: () {
                          Get.toNamed(
                            Routes.DETAILED_ITEM,
                            arguments: {'item': item},
                          );
                        },
                        onEdit: () {
                          Get.toNamed(
                            Routes.EDIT_ITEM,
                            arguments: {'item': item},
                          );
                        },
                      );
                    },
                  ),
            const SizedBox(height: 24),

            // Unlisted Items Section
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Unlisted Items',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.background,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            controller.unlistedItems.isEmpty
                ? const Text('No unlisted items.')
                : ListView.builder(
                    itemCount: controller.unlistedItems.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = controller.unlistedItems[index];
                      return sellItemCard(
                        item: item,
                        onTap: () {
                          Get.toNamed(
                            Routes.DETAILED_ITEM,
                            arguments: {'item': item},
                          );
                        },
                        onEdit: () {
                          Get.toNamed(
                            Routes.EDIT_ITEM,
                            arguments: {'item': item},
                          );
                        },
                      );
                    },
                  ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          Get.toNamed(Routes.ADD_ITEM);
        },
        child: Icon(Icons.add, color: AppColors.neutral10),
      ),
    );
  }

  Widget sellItemCard({
    required Map<String, dynamic> item,
    required VoidCallback onTap,
    required VoidCallback onEdit,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Gambar Item
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  item['image_url'] ?? '',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 80),
                ),
              ),
              const SizedBox(width: 16),

              // Info Item
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'] ?? 'No name',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      CurrencyFormatter.toRupiah(item['price']),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              // Tombol Aksi
              Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: onEdit,
                        tooltip: 'Edit Item',
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          Get.defaultDialog(
                            title: 'Delete Item',
                            middleText:
                                'Are you sure you want to delete this item?',
                            textCancel: 'Cancel',
                            textConfirm: 'Delete',
                            confirmTextColor: Colors.white,
                            buttonColor: AppColors.error,
                            onConfirm: () {
                              Get.back();
                              controller.deleteItem(item['id']);
                            },
                          );
                        },
                        tooltip: 'Delete Item',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Status Dropdown atau Badge
                  item['status']?.toString().toLowerCase() == 'pending'
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.neutral10,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Pending',
                            style: TextStyle(
                              color: AppColors.pending,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.neutral20,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.neutral40),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: item['status'],
                              onChanged: (String? newValue) {
                                if (newValue != null &&
                                    newValue != item['status']) {
                                  controller.onStatusChanged(
                                    item['id'],
                                    newValue,
                                  );
                                }
                              },
                              items: <String>['listed', 'unlisted']
                                  .map((String value) {
                                Icon icon = value == 'listed'
                                    ? Icon(
                                        Icons.check_circle,
                                        color: AppColors.secondary,
                                        size: 18,
                                      )
                                    : const Icon(
                                        Icons.cancel,
                                        color: AppColors.error,
                                        size: 18,
                                      );
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Row(
                                    children: [
                                      icon,
                                      const SizedBox(width: 8),
                                      Text(
                                        value,
                                        style: TextStyle(
                                          color: AppColors.neutral90,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              icon: const Icon(Icons.arrow_drop_down,
                                  color: AppColors.neutral60),
                            ),
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
