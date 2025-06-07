// ignore_for_file: unnecessary_overrides

import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:jualin/app/routes/app_pages.dart';
import 'package:jualin/app/themes/colors.dart';
import 'package:jualin/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  var isPasswordVisible = false.obs;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  var isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text;

    var headers = {'Content-Type': 'application/json'};

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Username dan Passsword tidak boleh kosong',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.error,
        colorText: AppColors.neutral10,
      );
      return;
    }

    isLoading.value = true;

    try {
      var url =
          Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.authEndpoints.login);

      Map body = {
        'username': username,
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
      String fullname = json['data']['fullname'].toString();
      String email = json['data']['email'].toString();

      await secureStorage.write(key: 'token', value: token);
      await secureStorage.write(key: 'username', value: username);
      await secureStorage.write(key: 'fullname', value: fullname);
      await secureStorage.write(key: 'email', value: email);
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
    passwordController.dispose();
    super.onClose();
  }
}
