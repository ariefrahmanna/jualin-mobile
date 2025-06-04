import 'package:get/get.dart';
import 'package:jualin/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ItemByCategoryController extends GetxController {
  final items = [].obs;
  final isLoading = false.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    final category = Get.arguments?['category'];
    if (category != null) {
      fetchItemsByCategory(category);
    }
  }

  Future<void> fetchItemsByCategory(String category) async {
    isLoading.value = true;
    var secureStorage = FlutterSecureStorage();
    String? token = await secureStorage.read(key: 'token');
    try {
      final url = Uri.parse(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.authEndpoints.items}?category=$category',
      );
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      final response = await http.get(
        url,
        headers: headers,
      );
      print("Token: $token");
      print("URL: $url");
      print("Headers: $headers");
      if (response.statusCode == 200) {
        final List data = json.decode(response.body)['data'];
        items.value = data;
      } else {
        items.clear();
        Get.snackbar('Error', 'Gagal memuat data item');
      }
    } catch (e) {
      items.clear();
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

  void increment() => count.value++;
}
