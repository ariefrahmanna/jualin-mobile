import 'package:get/get.dart';
import 'package:jualin/app/themes/colors.dart';
import 'package:jualin/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ItemByCategoryController extends GetxController {
  final items = [].obs;
  final isLoading = false.obs;

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
      var url = Uri.parse(ApiEndpoints.getItemsByCategory(category));

      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List data = json.decode(response.body)['data'];
        items.value = data;
      } else {
        items.clear();
        Get.snackbar('Error', 'Failed to load items');
      }
    } catch (e) {
      items.clear();
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
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
