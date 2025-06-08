import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jualin/app/routes/app_pages.dart';
import 'package:jualin/app/themes/colors.dart';
import 'package:jualin/widgets/item_card.dart';

import '../controllers/recently_added_controller.dart';

class RecentlyAddedView extends GetView<RecentlyAddedController> {
  const RecentlyAddedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recently Added',
          style: TextStyle(
            color: AppColors.neutral10,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: AppColors.neutral10,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: controller.recentlyAddedItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.68,
          ),
          itemBuilder: (context, index) {
            var item = controller.recentlyAddedItems[index];
            return ItemCard(
              item: item,
              onTap: () {
                Get.toNamed(Routes.DETAILED_ITEM, arguments: {
                  'item': item,
                });
              },
            );
          },
        ),
      ),
    );
  }

  String getLastAddedText(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime).inDays;

    if (difference == 0) {
      return 'Last Added: Today';
    } else if (difference == 1) {
      return 'Last Added: Yesterday';
    } else if (difference > 30) {
      return 'Last Added: >30 days ago';
    } else {
      return 'Last Added: $difference days ago';
    }
  }

  Widget recentlyAddedCard({
    required String title,
    required String price,
    required String imageName,
    required DateTime lastAdded,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/$imageName',
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              price,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              getLastAddedText(lastAdded),
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.neutral70,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Aksi tombol Buy
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
                child: const Text(
                  'Buy',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
