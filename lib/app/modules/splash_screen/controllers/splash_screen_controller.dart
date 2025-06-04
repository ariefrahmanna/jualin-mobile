import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:jualin/app/routes/app_pages.dart';

class SplashScreenController extends GetxController {
  Future<void> checkToken() async {
    await Future.delayed(Duration(seconds: 2));
    FlutterSecureStorage secureStorage = FlutterSecureStorage();
    String? token = await secureStorage.read(key: 'token');

    if (token != null && token.isNotEmpty) {
      Get.offAllNamed(Routes.DASHBOARD);
    } else {
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
}
