import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jualin/app/themes/colors.dart';
import 'package:jualin/utils/api_endpoints.dart';

class DetailProfileController extends GetxController {
  var user = <String, dynamic>{}.obs;
  var items = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  Future<void> fetchItems() async {
    isLoading.value = true;
    var secureStorage = FlutterSecureStorage();

    try {
      String? token = await secureStorage.read(key: 'token');

      var response = await http.get(
        Uri.parse(ApiEndpoints.getItemsByUsername(user['username'])),
        headers: {'Authorization': 'Bearer $token'},
      );

      var json = jsonDecode(response.body);

      if (response.statusCode != 200 || !json['status']) {
        throw json['message'];
      }

      items.value = json['data'];
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

  @override
  void onInit() {
    super.onInit();
    user.value = Get.arguments['user'];
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
