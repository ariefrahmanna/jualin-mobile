import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jualin/app/themes/colors.dart';
import 'package:jualin/utils/api_endpoints.dart';

class EditAccountController extends GetxController {
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  var isLoading = false.obs;

  // Simulasi update data ke API
  Future<void> saveChanges() async {
    String fullname = fullNameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();

    if (fullname.isEmpty || email.isEmpty || phone.isEmpty) {
      Get.snackbar(
        'Error',
        'Field tidak boleh kosong',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.error,
        colorText: AppColors.neutral10,
      );
      return;
    }

    isLoading.value = true;

    try {
      // Ganti dengan endpoint update user sesuai backend Anda
      Uri url = Uri.parse(ApiEndpoints.currentUser);

      Map<String, String> body = {
        'fullname': fullname,
        'email': email,
        'phone': phone,
      };

      var headers = {'Content-Type': 'application/json'};

      http.Response response = await http.put(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      final json = jsonDecode(response.body);

      if (response.statusCode != 200 || (json['status'] == false)) {
        Get.snackbar(
          'Error',
          json['message'] ?? 'Failed to update account',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.error,
          colorText: AppColors.neutral10,
        );
        isLoading.value = false;
        return;
      }

      Get.snackbar(
        'Success',
        'Account updated successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.success,
        colorText: AppColors.neutral10,
      );
      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan, silakan coba lagi',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.error,
        colorText: AppColors.neutral10,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
