import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jualin/app/themes/colors.dart';
import 'package:jualin/utils/widgets/item_card.dart';

import '../controllers/recently_added_controller.dart';

class RecentlyAddedView extends GetView<RecentlyAddedController> {
  const RecentlyAddedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recently Added'),
        centerTitle: true,
        backgroundColor: neutral10,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {},
          ),
        ],
        iconTheme: const IconThemeData(),
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
                //TODO: implement item detailed page
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
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              price,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 4),
            Text(
              getLastAddedText(lastAdded),
              style: const TextStyle(fontSize: 12, color: neutral70),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Aksi tombol Buy
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedItemColor,
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
