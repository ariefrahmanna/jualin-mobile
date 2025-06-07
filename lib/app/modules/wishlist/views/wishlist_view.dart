// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jualin/app/routes/app_pages.dart';
import 'package:jualin/app/themes/colors.dart';

import '../controllers/wishlist_controller.dart';

class WishlistView extends GetView<WishlistController> {
  const WishlistView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(
            'Wishlist',
            style: TextStyle(
              color: AppColors.neutral10,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColors.primary,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(
                Icons.person_outline,
                color: AppColors.neutral10,
              ),
              onPressed: () {
                Get.toNamed(Routes.MY_ACCOUNT);
              },
            ),
          ],
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.wishlists.isEmpty) {
            return const Center(child: Text('No items in wishlist'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.wishlists.length,
            itemBuilder: (context, index) {
              final item = controller.wishlists[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: wishlistItem(
                  title: item['name'],
                  price: "Rp${item['price']}",
                  imageUrl: item['image_url'],
                  onTap: () {
                    Get.toNamed(Routes.DETAILED_ITEM,
                        arguments: {'item': item});
                  },
                ),
              );
            },
          );
        }));
  }

  Widget wishlistItem({
    required String title,
    required String price,
    required String imageUrl,
    required VoidCallback onTap,
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
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        )),
                    const SizedBox(height: 8),
                    Text(price,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        )),
                  ],
                ),
              ),
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.favorite, color: AppColors.favorite),
                    onPressed: () {
                      // Tambahkan logika remove wishlist
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Tambahkan logika beli
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      minimumSize: const Size(80, 36),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Buy',
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
