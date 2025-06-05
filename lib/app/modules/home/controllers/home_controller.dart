import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:jualin/app/modules/recently_added/controllers/recently_added_controller.dart';
import 'package:jualin/app/themes/colors.dart';
import 'package:http/http.dart' as http;
import 'package:jualin/utils/api_endpoints.dart';

class HomeController extends GetxController {
  var recentlyAddedItems = [].obs;
  var searchResults = [].obs;
  var isLoading = false.obs;
  var isSearching = false.obs;

  var recentlyAddedController = Get.put(RecentlyAddedController());

  Future<void> fetchRecentlyAddedPreview() async {
    try {
      isLoading.value = true;
      await recentlyAddedController.fetchRecentlyAddedItems();

      // Ambil hanya 5 item sebagai preview
      recentlyAddedItems.value =
          recentlyAddedController.recentlyAddedItems.take(5).toList();
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: errors,
        colorText: neutral10,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchItems(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    try {
      var secureStorage = FlutterSecureStorage();
      String? token = await secureStorage.read(key: 'token');
      var url = Uri.parse(
          '${ApiEndpoints.baseUrl}${ApiEndpoints.authEndpoints.items}?search=$query');
      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      var response = await http.get(url, headers: headers);

      isSearching.value = true;
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        searchResults.value = data;
      } else {
        searchResults.clear();
        Get.snackbar('Error', 'Search failed',
            backgroundColor: errors, colorText: neutral10);
      }
    } catch (e) {
      searchResults.clear();
      Get.snackbar('Error', e.toString(),
          backgroundColor: errors, colorText: neutral10);
    } finally {
      isSearching.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchRecentlyAddedPreview();
  }
}
