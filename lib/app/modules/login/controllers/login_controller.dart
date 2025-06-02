import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jualin/app/routes/app_pages.dart';
import 'package:jualin/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var isPasswordVisible = false.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    var headers = {'Content-Type': 'application/json'};

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Email dan Passsword tidak boleh kosong');
      return;
    }

    isLoading.value = true;

    try {
      var url =
        Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.authEndpoints.login);

      Map body = {'username': email, 'password': password};

      http.Response response =
        await http.post(url, body: jsonEncode(body), headers: headers);
      final json = jsonDecode(response.body);

      if (response.statusCode == 200) {

        if (json['status'] == true) {
          var token = json['token'];
          
          final SharedPreferences? prefs = await _prefs;
          await prefs?.setString('token', token.toString());
          Get.snackbar('Sukses', json['message']);
          Get.offAllNamed(Routes.DASHBOARD);
        } else {
          Get.snackbar('Gagal', json['message']);
        }

      } else {
        Get.snackbar('Gagal', json['message']);
      }
    }catch(error) {
      Get.snackbar('Login Error', error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  final count = 0.obs;
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
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
