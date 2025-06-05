// ignore_for_file: unnecessary_overrides
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
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
        '${ApiEndpoints.baseUrl}transactions', // pastikan endpoint sesuai API kamu
      );
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final List data = json.decode(response.body)['data'];
        transactions.value = data;
      } else {
        transactions.clear();
        Get.snackbar('Error', 'Gagal memuat data transaksi');
      }
    } catch (e) {
      transactions.clear();
      Get.snackbar('Error', 'Terjadi kesalahan');
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
