import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jualin/app/themes/colors.dart';
import 'package:jualin/utils/api_endpoints.dart';

class DetailedItemController extends GetxController {
  var item = {}.obs;
  var isWishlisted = false.obs;
  var isLoading = false.obs;
  var isLoadingWishlist = false.obs;

  Future<void> fetchWishlist() async {
    isLoading.value = true;

    var secureStorage = FlutterSecureStorage();
    String? token = await secureStorage.read(key: 'token');
    try {
      var url = Uri.parse(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.authEndpoints.userWishlists}',
      );

      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      var json = jsonDecode(response.body);

      if (response.statusCode != 200 || !json['status']) {
        item.clear();
        throw json['message'];
      }

      List<dynamic> wishlists = json['data']['item_ids'];

      if (wishlists.contains(item['id'])) {
        isWishlisted.value = true;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.error,
        colorText: AppColors.neutral10,
      );
    } finally {
      isLoading.value = true;
    }
  }

  void toggleWishlist() async {
    isLoadingWishlist.value = true;
    var secureStorage = FlutterSecureStorage();
    String? token = await secureStorage.read(key: 'token');

    if (isWishlisted.value) {
      var url = Uri.parse(
          "${ApiEndpoints.baseUrl}${ApiEndpoints.authEndpoints.removeWishlist}/${item['id']}");
      var response = await http.delete(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
      var json = jsonDecode(response.body);

      if (!json['status']) {
        throw json['message'];
      }
    } else {
      var url = Uri.parse(
          "${ApiEndpoints.baseUrl}${ApiEndpoints.authEndpoints.wishlists}");
      var response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: {'item_id': item['id'].toString()},
      );
      var json = jsonDecode(response.body);

      if (!json['status']) {
        throw json['message'];
      }
    }

    isWishlisted.value = !isWishlisted.value;
    isLoadingWishlist.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    item.value = Get.arguments['item'];
    fetchWishlist();
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
