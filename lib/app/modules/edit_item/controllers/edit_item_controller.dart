import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jualin/app/modules/sell_items/controllers/sell_items_controller.dart';
import 'package:jualin/app/themes/colors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

import 'package:jualin/utils/api_endpoints.dart';

class EditItemController extends GetxController {
  final formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  var categoryController = TextEditingController();
  var imageUrlController = TextEditingController();
  SellItemsController sellItemsController = Get.put(SellItemsController());

  var isLoading = false.obs;

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    categoryController.dispose();
    imageUrlController.dispose();
    super.onClose();
  }

  Future<void> editItem(int id) async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;

    final storage = const FlutterSecureStorage();
    String? token = await storage.read(key: 'token');

    try {
      var url = Uri.parse('${ApiEndpoints.baseUrl}/items/$id');
      var response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': nameController.text,
          'description': descriptionController.text,
          'price': priceController.text,
          'category': categoryController.text,
          'image_url': imageUrlController.text,
        }),
      );

      if (response.statusCode == 200) {
        sellItemsController.fetchSellItems();
        Get.back(); // Kembali ke halaman sebelumnya
        Get.snackbar('Success', 'Item updated successfully',
            backgroundColor: AppColors.success, colorText: AppColors.neutral10);
      } else {
        final error = jsonDecode(response.body);
        Get.snackbar('Error', error['message'] ?? 'Failed to update item',
            backgroundColor: AppColors.error, colorText: AppColors.neutral10);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update item',
          backgroundColor: AppColors.error, colorText: AppColors.neutral10);
    } finally {
      isLoading.value = false;
    }
  }
}
