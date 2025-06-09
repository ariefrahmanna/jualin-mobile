import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jualin/app/modules/my_account/controllers/my_account_controller.dart';
import 'package:jualin/app/routes/app_pages.dart';
import 'package:jualin/app/themes/colors.dart';
import 'package:jualin/utils/api_endpoints.dart';

class EditAccountController extends GetxController {
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var contactNumberController = TextEditingController();
  MyAccountController myAccountController = Get.put(MyAccountController());
  String username = '';

  var isLoading = false.obs;

  // Simulasi update data ke API
  Future<void> saveChanges() async {
    String fullname = fullNameController.text.trim();
    String email = emailController.text.trim();
    String contactNumber = contactNumberController.text.trim();

    if (fullname.isEmpty || email.isEmpty || contactNumber.isEmpty) {
      throw 'Field cannot be empty';
    }

    isLoading.value = true;

    try {
      FlutterSecureStorage secureStorage = const FlutterSecureStorage();
      String? token = await secureStorage.read(key: 'token');
      Uri url = Uri.parse(ApiEndpoints.currentUser);

      Map<String, String> body = {
        'username': username,
        'fullname': fullname,
        'email': email,
        'contact_number': contactNumber,
      };

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      http.Response response = await http.put(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      final json = jsonDecode(response.body);

      if (response.statusCode != 200 || (json['status'] == false)) {
        throw json['message'] ?? 'Failed to update account';
      }

      await secureStorage.write(key: 'fullname', value: fullname);
      await secureStorage.write(key: 'email', value: email);
      await secureStorage.write(key: 'contact_number', value: contactNumber);
      Get.back();
      myAccountController.readProfile();
      Get.snackbar(
        'Success',
        'Account updated successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.success,
        colorText: AppColors.neutral10,
      );
    } catch (e) {
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

  void setInitialData(
      {required String username,
      required String fullname,
      required String email,
      required String phone}) {
    this.username = username;
    fullNameController.text = fullname;
    emailController.text = email;
    contactNumberController.text = phone;
  }

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null) {
      setInitialData(
        username: args['username'] ?? '',
        fullname: args['fullname'] ?? '',
        email: args['email'] ?? '',
        phone: args['contactNumber'] ?? '',
      );
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    contactNumberController.dispose();
    super.onClose();
  }
}
