import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/recently_viewed_controller.dart';

class RecentlyViewedView extends GetView<RecentlyViewedController> {
  const RecentlyViewedView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recently Viewed'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.black),
            onPressed: () {},
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          recentlyViewedItem(
            title: 'Kursi Abu',
            price: 'Rp799.000',
            imageName: 'kursi_abu.jpg',
            lastViewed: DateTime.now().subtract(const Duration(hours: 5)),
          ),
          const SizedBox(height: 16),
          recentlyViewedItem(
            title: 'Keyboard',
            price: 'Rp299.000',
            imageName: 'keyboard.png',
            lastViewed:
                DateTime.now().subtract(const Duration(days: 1)), // yesterday
          ),
          const SizedBox(height: 16),
          recentlyViewedItem(
            title: 'Plushies Pikachu',
            price: 'Rp499.000',
            imageName: 'plushies.png',
            lastViewed:
                DateTime.now().subtract(const Duration(days: 32)), // >30 days
          ),
        ],
      ),
    );
  }

  String getLastViewedText(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime).inDays;

    if (difference == 0) {
      return 'Last viewed: Today';
    } else if (difference == 1) {
      return 'Last viewed: Yesterday';
    } else if (difference > 30) {
      return 'Last viewed: >30 days ago';
    } else {
      return 'Last viewed: $difference days ago';
    }
  }

  Widget recentlyViewedItem({
    required String title,
    required String price,
    required String imageName,
    required DateTime lastViewed,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/$imageName',
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
                  const SizedBox(height: 4),
                  Text(
                    getLastViewedText(lastViewed),
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Tombol Buy ditekan
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4CAF50),
                minimumSize: const Size(80, 36),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: const TextStyle(fontSize: 14),
              ),
              child: const Text('Buy'),
            ),
          ],
        ),
      ),
    );
  }
}
