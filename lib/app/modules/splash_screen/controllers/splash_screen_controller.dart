// ignore_for_file: avoid_print, unnecessary_overrides

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:jualin/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenController extends GetxController {
  //TODO: Implement SplashScreenController

  final count = 0.obs;

  Future<void> checkToken() async {
    print("SplashScreen: Mulai cek token");

    await Future.delayed(Duration(seconds: 2));
    FlutterSecureStorage secureStorage = FlutterSecureStorage();
    String? token = await secureStorage.read(key: 'token');

    print("SplashScreen: Token = $token");

    if (token != null && token.isNotEmpty) {
      print("SplashScreen: Navigasi ke DASHBOARD");
      Get.offAllNamed(Routes.DASHBOARD);
    } else {
      print("SplashScreen: Navigasi ke LOGIN");
      Get.offAllNamed(Routes.LOGIN);
    }
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

  void increment() => count.value++;
}
