import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../themes/colors.dart';
import '../controllers/transactions_controller.dart';

class TransactionsView extends GetView<TransactionsController> {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<TransactionsController>(
      () => TransactionsController(),
    );
    return Scaffold(
      backgroundColor: neutral10,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'My Transactions',
          style: TextStyle(
            color: neutral10,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: neutral10),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: primaryColor),
          );
        }
        if (controller.transactions.isEmpty) {
          return Center(
            child: Text(
              'No transactions found',
              style: TextStyle(
                color: neutral70,
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
              color: neutral10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                leading: Icon(Icons.receipt_long, color: primaryColor),
                title: Text(
                  trx['item_name'] ?? '-',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: text,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tanggal: ${trx['date'] ?? '-'}',
                      style: const TextStyle(fontSize: 13, color: neutral70),
                    ),
                    Text(
                      'Status: ${trx['status'] ?? '-'}',
                      style: TextStyle(
                        fontSize: 13,
                        color: trx['status'] == 'success'
                            ? Colors.green
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
                    color: primaryColor,
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
