import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jualin/app/routes/app_pages.dart';
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
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.MY_ACCOUNT);
            },
            icon: Icon(
              Icons.person_outline,
              color: AppColors.neutral10,
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchTransactions();
        },
        child: Obx(
          () {
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }
            if (controller.transactions.isEmpty) {
              return Center(child: Text('No Transactions'));
            }
            return RefreshIndicator(
              onRefresh: () async {
                await controller.fetchTransactions();
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.transactions.length,
                itemBuilder: (context, index) {
                  final item = controller.transactions[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: transactionItem(
                      item: item,
                      title: item['name'],
                      price: CurrencyFormatter.toRupiah(item['price']),
                      imageUrl: item['image_url'],
                      status: item['status'],
                      onTap: () {},
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
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
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.broken_image);
                  },
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
                    Text(
                      price,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 12,
                        color: status.toLowerCase() == 'pending'
                            ? AppColors.pending
                            : status.toLowerCase() == 'sold'
                                ? AppColors.success
                                : AppColors.text, // fallback/default
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
