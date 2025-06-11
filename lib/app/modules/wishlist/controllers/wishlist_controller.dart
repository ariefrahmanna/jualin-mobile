// ignore_for_file: unnecessary_overrides

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:jualin/app/themes/colors.dart';
import 'package:jualin/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class WishlistController extends GetxController {
  var wishlists = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  Future<void> fetchWishlist() async {
    isLoading.value = true;
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');

    try {
      final response = await http.get(
        Uri.parse(ApiEndpoints.getUserWishlists),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      final json = jsonDecode(response.body);
      if (response.statusCode == 200 && json['status']) {
        List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(json['data']);

        List<Map<String, dynamic>> soldItems = data
            .where(
                (item) => (item['status']?.toString().toLowerCase() == 'sold'))
            .toList();

        for (var item in soldItems) {
          final itemId = item['id'];
          await http.delete(
            Uri.parse(ApiEndpoints.removeWishlistByItemId(itemId)),
            headers: {'Authorization': 'Bearer $token'},
          );
        }
        wishlists.assignAll(data);
      } else {
        throw json['message'] ?? 'Failed to load wishlist';
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: AppColors.error,
        colorText: AppColors.neutral10,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleWishlist(Map<String, dynamic> item) async {
    final itemId = item['id'];
    var exists = wishlists.any((e) => e['id'] == itemId);

    if (exists) {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'token');
      final response = await http.delete(
        Uri.parse(ApiEndpoints.removeWishlistByItemId(itemId)),
        headers: {'Authorization': 'Bearer $token'},
      );

      final json = jsonDecode(response.body);
      if (!json['status']) throw json['message'];
      wishlists.removeWhere((e) => e['id'] == itemId);
    }

    wishlists.refresh();
  }

  @override
  void onInit() {
    super.onInit();
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
