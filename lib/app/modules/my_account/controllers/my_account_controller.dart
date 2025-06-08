// ignore_for_file: unnecessary_overrides

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:jualin/app/routes/app_pages.dart';
import 'package:jualin/app/themes/colors.dart';
import 'package:http/http.dart' as http;
import 'package:jualin/utils/api_endpoints.dart';

class MyAccountController extends GetxController {
  RxString fullname = ''.obs;
  RxString email = ''.obs;

  Future<void> logout() async {
    FlutterSecureStorage secureStorage = FlutterSecureStorage();
    var token = await secureStorage.read(key: 'token');

    var url = Uri.parse(ApiEndpoints.logout);

    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var response = await http.delete(url, headers: headers);
    if (response.statusCode == 200) {
      await secureStorage.deleteAll();
      Get.snackbar(
        'Success',
        'Logged out successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.success,
        colorText: AppColors.neutral10,
      );
      Get.offAllNamed(Routes.LOGIN);
    } else {
      Get.snackbar(
        'Error',
        'Unable to log out',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.error,
        colorText: AppColors.neutral10,
      );
    }
  }

  Future<void> readProfile() async {
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    String? awaitFullname = await secureStorage.read(key: 'fullname');
    String? awaitEmail = await secureStorage.read(key: 'email');
    fullname.value = awaitFullname ?? '';
    email.value = awaitEmail ?? '';
  }

  @override
  void onInit() {
    super.onInit();
    readProfile();
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
