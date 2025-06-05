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

  Future<void> fetchWishlist(int itemId) async {
    isLoading.value = true;

    var secureStorage = FlutterSecureStorage();
    String? token = await secureStorage.read(key: 'token');
    try {
      var url = Uri.parse(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.authEndpoints.wishlists}',
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
        throw 'Item with id = id not found';
      }

      List<dynamic> wishlists = json['data']['item_ids'];

      if (wishlists.contains(itemId)) {
        isWishlisted.value = true;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: errors,
        colorText: neutral10,
      );
    } finally {
      isLoading.value = true;
    }
  }

  void toggleWishlist() {
    isWishlisted.value = !isWishlisted.value;
  }

  @override
  void onInit() {
    super.onInit();
    item.value = Get.arguments['item'];
    fetchWishlist(item['id']);
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
