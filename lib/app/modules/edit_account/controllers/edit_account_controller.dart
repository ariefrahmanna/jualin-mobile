import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jualin/app/themes/colors.dart';

class EditAccountController extends GetxController {
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  var isLoading = false.obs;

  // Simulasi update data, bisa diganti dengan API call
  void saveChanges() async {
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
    await Future.delayed(const Duration(seconds: 1)); // Simulasi loading

    Get.snackbar(
      'Success',
      'Account updated successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.success,
      colorText: AppColors.neutral10,
    );
    isLoading.value = false;
    Get.back();
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
