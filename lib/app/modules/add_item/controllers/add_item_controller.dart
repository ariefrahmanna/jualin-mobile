import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jualin/app/modules/sell_items/controllers/sell_items_controller.dart';
import 'package:jualin/app/themes/colors.dart';
import 'package:jualin/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class AddItemController extends GetxController {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var priceController = TextEditingController();
  var categoryController = TextEditingController();
  var imageUrlController = TextEditingController();
  var descriptionController = TextEditingController();
  SellItemsController sellItemsController = Get.put(SellItemsController());
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> addItem() async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;
    var secureStorage = const FlutterSecureStorage();
    String? token = await secureStorage.read(key: 'token');
    try {
      var url = Uri.parse(ApiEndpoints.items);
      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      var body = json.encode({
        'name': nameController.text,
        'price': priceController.text,
        'category': categoryController.text,
        'image_url': imageUrlController.text,
        'description': descriptionController.text,
      });
      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        sellItemsController.fetchSellItems();
        Get.back();
        Get.snackbar('Success', 'Item added successfully');
      } else {
        var body = json.decode(response.body);
        throw body['message'] ?? 'Failed to add item';
      }
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
  void onClose() {
    nameController.dispose();
    priceController.dispose();
    categoryController.dispose();
    imageUrlController.dispose();
    super.onClose();
  }
}
