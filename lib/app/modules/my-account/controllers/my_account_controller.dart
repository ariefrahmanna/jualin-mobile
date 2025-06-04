// ignore_for_file: unnecessary_overrides

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:jualin/app/routes/app_pages.dart';
import 'package:jualin/app/themes/colors.dart';
import 'package:http/http.dart' as http;

class MyAccountController extends GetxController {
  Future<void> logout() async {
    FlutterSecureStorage secureStorage = FlutterSecureStorage();
    var token = await secureStorage.read(key: 'token');

    var response = await http.delete(
      Uri.parse('https://your-ngrok-url/api/logout'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      await secureStorage.deleteAll();
      Get.snackbar(
        'Success',
        'Logged out successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: success,
        colorText: neutral10,
      );
      Get.offAllNamed(Routes.LOGIN);
    } else {
      Get.snackbar(
        'Error',
        'Unable to log out',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: errors,
        colorText: neutral10,
      );
    }

    await secureStorage.deleteAll();
    Get.snackbar(
      'Success',
      'Logged out successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: success,
      colorText: neutral10,
    );

    Get.offAllNamed(Routes.LOGIN);
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
    super.onClose();
  }
}
