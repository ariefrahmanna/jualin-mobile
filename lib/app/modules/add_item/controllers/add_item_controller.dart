import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jualin/app/modules/sell_items/controllers/sell_items_controller.dart';
import 'package:jualin/app/themes/colors.dart';
import 'package:jualin/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class AddItemController extends GetxController {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var priceController = TextEditingController();
  var categoryController = TextEditingController();
  var imageUrlController = TextEditingController();
  var descriptionController = TextEditingController();
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

  Future<void> addItem() async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;

    var secureStorage = const FlutterSecureStorage();
    String? token = await secureStorage.read(key: 'token');

    try {
      if (pickedImage == null) {
        throw ('Please select an image');
      }
      var url = Uri.parse(ApiEndpoints.items);
      var request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer $token';
      request.fields['name'] = nameController.text;
      request.fields['price'] = priceController.text;
      request.fields['category'] = categoryController.text;
      request.fields['description'] = descriptionController.text;
      request.files
          .add(await http.MultipartFile.fromPath('image', pickedImage!.path));

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      var json = jsonDecode(responseBody);

      if (json['status'] == false) {
        throw json['message'] ?? '';
      } else if (response.statusCode != 201) {
        throw json['message'] ?? '';
      }
      sellItemsController.fetchSellItems();
      Get.back();
      Get.snackbar(
        'Success',
        'Item added successfully',
        backgroundColor: AppColors.success,
        colorText: AppColors.neutral10,
      );
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
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
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
