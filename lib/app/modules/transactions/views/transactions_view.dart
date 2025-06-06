import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jualin/app/routes/app_pages.dart';
import '../../../themes/colors.dart';
import '../controllers/transactions_controller.dart';

class TransactionsView extends GetView<TransactionsController> {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
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
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }
        if (controller.transactions.isEmpty) {
          return Center(
            child: Text(
              'No transactions found',
              style: TextStyle(
                color: AppColors.neutral70,
                fontSize: 16,
              ),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.transactions.length,
          itemBuilder: (context, index) {
            final trx = controller.transactions[index];
            return Card(
              color: AppColors.neutral10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                leading: Icon(
                  Icons.receipt_long,
                  color: AppColors.primary,
                ),
                title: Text(
                  trx['item_name'] ?? '-',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tanggal: ${trx['date'] ?? '-'}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.neutral70,
                      ),
                    ),
                    Text(
                      'Status: ${trx['status'] ?? '-'}',
                      style: TextStyle(
                        fontSize: 13,
                        color: trx['status'] == 'success'
                            ? AppColors.primary
                            : (trx['status'] == 'pending'
                                ? Colors.orange
                                : Colors.red),
                      ),
                    ),
                  ],
                ),
                trailing: Text(
                  'Rp ${trx['total'] ?? '0'}',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
