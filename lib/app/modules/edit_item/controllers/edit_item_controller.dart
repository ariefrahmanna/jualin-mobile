import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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

  XFile? pickedImage;
  var imageName = ''.obs;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      imageName.value = pickedImage!.name;
    }
  }

  Future<void> editItem(int id) async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;

    final storage = const FlutterSecureStorage();
    String? token = await storage.read(key: 'token');

    try {
      var url = Uri.parse('${ApiEndpoints.baseUrl}/items/$id');

      http.BaseResponse response;

      if (pickedImage != null) {
        var request = http.MultipartRequest('POST', url);
        request.headers['Authorization'] = 'Bearer $token';
        request.fields['_method'] = 'PUT';
        request.fields['name'] = nameController.text;
        request.fields['description'] = descriptionController.text;
        request.fields['price'] = priceController.text;
        request.fields['category'] = categoryController.text;
        request.files
            .add(await http.MultipartFile.fromPath('image', pickedImage!.path));

        response = await request.send();
        var responseBody =
            await (response as http.StreamedResponse).stream.bytesToString();
        if (response.statusCode == 200) {
          sellItemsController.fetchSellItems();
          Get.back();
          Get.snackbar('Success', 'Item updated successfully',
              backgroundColor: AppColors.success,
              colorText: AppColors.neutral10);
        } else {
          throw jsonDecode(responseBody)['message'] ?? 'Failed to update item';
        }
      } else {
        response = await http.put(
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
      }
      if (response.statusCode == 200) {
        sellItemsController.fetchSellItems();
        Get.back(); // Kembali ke halaman sebelumnya
        Get.snackbar('Success', 'Item updated successfully',
            backgroundColor: AppColors.success, colorText: AppColors.neutral10);
      } else {
        throw 'failed to update item ';
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          backgroundColor: AppColors.error, colorText: AppColors.neutral10);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    categoryController.dispose();
    imageUrlController.dispose();
    super.onClose();
  }
}
