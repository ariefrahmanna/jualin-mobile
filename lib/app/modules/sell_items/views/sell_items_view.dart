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
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Section: Listed Items
            Align(
              alignment: Alignment
                  .centerLeft, // atau Alignment.topLeft sesuai kebutuhan
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
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
                          Get.toNamed(Routes.DETAILED_ITEM,
                              arguments: {'item': item});
                        },
                        onEdit: () {
                          //TODO:  ke halaman edit
                        },
                      );
                    },
                  ),

            const SizedBox(height: 24),

            // Section: Unlisted Items
            Align(
              alignment: Alignment
                  .centerLeft, // atau Alignment.topLeft sesuai kebutuhan
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'unlisted Items',
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
                          Get.toNamed(Routes.DETAILED_ITEM,
                              arguments: {'item': item});
                        },
                        onEdit: () {
                          //TODO:  ke halaman edit
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
          Get.toNamed(Routes
              .ADD_ITEM); // Pastikan route sudah terdaftar di app_pages.dart
        },
        child: const Icon(Icons.add, color: AppColors.neutral10),
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
                      "Rp${item['price'] ?? 0}",
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
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: onEdit,
                    tooltip: 'Edit Item',
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Contoh aksi: buka detail
                      onTap();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      minimumSize: const Size(80, 36),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Detail',
                        style: TextStyle(
                            fontSize: 14, color: AppColors.neutral10)),
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
