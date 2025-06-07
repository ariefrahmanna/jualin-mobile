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
        Uri.parse(
            '${ApiEndpoints.baseUrl}${ApiEndpoints.authEndpoints.userWishlists}'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      final json = jsonDecode(response.body);
      if (response.statusCode == 200 && json['status']) {
        wishlists.assignAll(List<Map<String, dynamic>>.from(json['data']));
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
    var url = Uri.parse(
          "${ApiEndpoints.baseUrl}${ApiEndpoints.authEndpoints.removeWishlist}/${item['id']}",
        );
    final response = await http.delete(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    final json = jsonDecode(response.body);
    if (!json['status']) throw json['message'];
    wishlists.removeWhere((e) => e['id'] == itemId);

  } else {

  }
  wishlists.refresh();
}


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    fetchWishlist();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
