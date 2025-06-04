import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jualin/app/routes/app_pages.dart';
import 'package:jualin/app/themes/colors.dart';
import '../controllers/sell_items_controller.dart';
class SellItemsView extends StatelessWidget {
  const SellItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral10,
      appBar: AppBar(
        title: const Text('Your Items'),
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: Get.find<SellItemsController>().items.length,
          itemBuilder: (context, index) {
            final item = Get.find<SellItemsController>().items[index];
            return wishlistItem(
              title: item.title,
              price: item.price,
              imageName: item.imagePath,
              status: item.status,
              index: index,
            );
          },
        ),
      ),
    );
  }

  Widget wishlistItem({
    required String title,
    required String price,
    required String imageName,
    required String status,
    required int index,
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
                imageName,
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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: neutral50,
                    ),
                  ),
                  child: DropdownButton<String>(
                    value: status,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        Get.find<SellItemsController>()
                            .updateItemStatus(index, newValue);
                      }
                    },
                    items: <String>['Ready', 'Sold Out']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                            fontWeight: FontWeight.normal, // Removed bold
                            fontSize: 14,
                            color: text,
                          ),
                        ),
                      );
                    }).toList(),
                    underline: Container(), // Remove the default underline
                    isExpanded: false,
                    icon: const Icon(Icons.arrow_drop_down),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
