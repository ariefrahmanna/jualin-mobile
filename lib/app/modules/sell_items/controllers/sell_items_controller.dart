// ignore_for_file: unnecessary_overrides

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jualin/app/themes/colors.dart';
import 'package:jualin/utils/api_endpoints.dart';

class SellItemsController extends GetxController {
  var status = 'listed'.obs;
  var listedItems = [].obs;
  var unlistedItems = [].obs;
  var secureStorage = FlutterSecureStorage();

  Future<void> fetchSellItems() async {
    try {
      var token = await secureStorage.read(key: 'token');
      var url = Uri.parse(ApiEndpoints.getUserItems);
      var headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      var response = await http.get(url, headers: headers);
      var body = json.decode(response.body);
      if (response.statusCode == 200 && body['status']) {
        var items = List<Map<String, dynamic>>.from(body['data']);

        listedItems.value =
            items.where((item) => item['status'] == 'listed').toList();
        unlistedItems.value =
            items.where((item) => item['status'] == 'unlisted').toList();
      } else {
        throw body['message'] ?? 'Failed to load items';
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: AppColors.error,
        colorText: AppColors.neutral10,
      );
    }
  }

  Future<void> onStatusChanged(int itemId, String newStatus) async {
    try {
      var token = await secureStorage.read(key: 'token');
      var url = Uri.parse(ApiEndpoints.itemsById(itemId));
      var headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };
      var body = jsonEncode({
        'status': newStatus.toLowerCase(),
      });
      var response = await http.put(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        fetchSellItems();
      } else {
        throw jsonDecode(response.body)['message'] ?? 'Gagal mengubah status';
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: AppColors.error,
        colorText: AppColors.neutral10,
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchSellItems();
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
