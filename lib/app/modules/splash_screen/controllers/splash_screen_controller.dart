import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jualin/app/routes/app_pages.dart';
import 'package:jualin/utils/api_endpoints.dart';

class SplashScreenController extends GetxController {
  Future<void> checkToken() async {
    await Future.delayed(Duration(seconds: 2));
    FlutterSecureStorage secureStorage = FlutterSecureStorage();
    String? token = await secureStorage.read(key: 'token');

    if (token == null || token.isEmpty) {
      await secureStorage.deleteAll();
      Get.offAllNamed(Routes.LOGIN);
      return;
    }

    var url =
        Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.authEndpoints.checkToken);
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode != 200 || !jsonDecode(response.body)['status']) {
      await secureStorage.deleteAll();
      Get.offAllNamed(Routes.LOGIN);
      return;
    }

    Get.offAllNamed(Routes.DASHBOARD);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    checkToken();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
