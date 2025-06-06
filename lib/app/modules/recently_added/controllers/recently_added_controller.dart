import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:jualin/app/themes/colors.dart';
import 'package:jualin/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class RecentlyAddedController extends GetxController {
  var recentlyAddedItems = [].obs;
  var isLoading = false.obs;

  Future<void> fetchRecentlyAddedItems() async {
    isLoading.value = true;

    var secureStorage = const FlutterSecureStorage();
    String? token = await secureStorage.read(key: 'token');

    try {
      var url = Uri.parse(
          '${ApiEndpoints.baseUrl}${ApiEndpoints.authEndpoints.items}');
      var headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        List data = json.decode(response.body)['data'];
        recentlyAddedItems.value = data;
      } else {
        recentlyAddedItems.clear();
        Get.snackbar(
          'Error',
          'unable to fetch data',
          backgroundColor: AppColors.error,
          colorText: AppColors.neutral10,
        );
      }
    } catch (e) {
      recentlyAddedItems.clear();
      Get.snackbar(
        'Error',
        'unable to fetch data',
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
    super.onClose();
  }
}
