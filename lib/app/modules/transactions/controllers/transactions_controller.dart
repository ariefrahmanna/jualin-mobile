import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jualin/app/themes/colors.dart';
import 'package:jualin/utils/api_endpoints.dart';

class TransactionsController extends GetxController {
  final transactions = [].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    isLoading.value = true;
    var secureStorage = const FlutterSecureStorage();
    String? token = await secureStorage.read(key: 'token');
    try {
      final url = Uri.parse(
        ApiEndpoints.getPendingPurchases, // pastikan endpoint sesuai API kamu
      );
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        List data = json.decode(response.body)['data'];
        transactions.value = data;
        for (var item in List<Map<String, dynamic>>.from(data)) {
          var currentStatus = item['status']?.toString().toLowerCase();
          if (!['pending', 'sold'].contains(currentStatus)) {
            await deleteTransaction(item['id']);
          }
        }
      } else {
        transactions.clear();
        Get.snackbar(
          'Error',
          'Failed to fetch transactions',
          backgroundColor: AppColors.error,
          colorText: AppColors.neutral10,
        );
      }
    } catch (e) {
      transactions.clear();
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: AppColors.error,
        colorText: AppColors.neutral10,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteTransaction(int itemId) async {
    isLoading.value = true;
    var secureStorage = const FlutterSecureStorage();
    String? token = await secureStorage.read(key: 'token');
    try {
      final url = Uri.parse(ApiEndpoints.deletePendingPurchases(itemId));
      final headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };
      final response = await http.delete(url, headers: headers);
      var body = jsonDecode(response.body);

      if (body['status'] == false) {
        throw 'Failed to delete transaction';
      }

      await fetchTransactions();
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: AppColors.error,
        colorText: AppColors.neutral10,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
