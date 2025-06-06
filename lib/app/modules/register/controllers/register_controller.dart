// ignore_for_file: unnecessary_overrides

import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jualin/app/routes/app_pages.dart';
import 'package:jualin/app/themes/colors.dart';
import 'package:jualin/utils/api_endpoints.dart';

class RegisterController extends GetxController {
  final fullnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  final isPasswordVisible = false.obs;
  var isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final fullname = fullnameController.text;

    var headers = {'Content-Type': 'application/json'};

    if (email.isEmpty ||
        password.isEmpty ||
        fullname.isEmpty ||
        username.isEmpty) {
      Get.snackbar(
        'Error',
        'field tidak boleh kosong',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.error,
        colorText: AppColors.neutral10,
      );
      return;
    }

    isLoading.value = true;

    try {
      Uri url =
          Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.authEndpoints.register);

      Map body = {
        'username': username,
        'fullname': fullname,
        'email': email,
        'password': password,
      };

      http.Response response = await http.post(
        url,
        body: jsonEncode(body),
        headers: headers,
      );
      final json = jsonDecode(response.body);

      if (response.statusCode != 200 || !json['status']) {
        Get.snackbar(
          'error',
          json['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.error,
          colorText: AppColors.neutral10,
        );
        return;
      }

      FlutterSecureStorage secureStorage = FlutterSecureStorage();
      String token = json['token'].toString();

      await secureStorage.write(key: 'token', value: token);
      await secureStorage.write(key: 'username', value: username);
      await secureStorage.write(key: 'fullname', value: fullname);
      await secureStorage.write(key: 'email', value: email);

      Get.snackbar(
        'Success',
        json['message'],
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.success,
        colorText: AppColors.neutral10,
      );

      Get.offAllNamed(Routes.DASHBOARD);
    } catch (error) {
      Get.snackbar(
        'error',
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
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
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    fullnameController.dispose();
    super.onClose();
  }
}
