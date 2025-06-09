import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jualin/app/themes/colors.dart';
import 'package:jualin/utils/currency_formatter.dart';
import '../controllers/transactions_controller.dart';

class TransactionsView extends GetView<TransactionsController> {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'My Transactions',
          style: TextStyle(
            color: AppColors.neutral10,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.transactions.isEmpty) {
          return const Center(child: Text('No Transactions'));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.transactions.length,
          itemBuilder: (context, index) {
            final item = controller.transactions[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: transactionItem(
                item: item,
                title: item['name'],
                price: "Rp${item['price']}",
                imageUrl: item['image_url'],
                status: item['status'],
                onTap: () {
                  // Aksi jika ingin ke detail item
                  // Get.toNamed(Routes.DETAILED_ITEM, arguments: {'item': item});
                },
              ),
            );
          },
        );
      }),
    );
  }

  Widget transactionItem({
    required Map<String, dynamic> item,
    required String title,
    required String price,
    required String imageUrl,
    required String status,
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
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.broken_image),
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
                    Text(CurrencyFormatter.toRupiah(price),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        )),
                    const SizedBox(height: 8),
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.pending,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
