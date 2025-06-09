import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jualin/app/modules/transactions/controllers/transactions_controller.dart';
import 'package:jualin/app/modules/wishlist/controllers/wishlist_controller.dart';
import 'package:jualin/app/routes/app_pages.dart';
import 'package:jualin/app/themes/colors.dart';
import 'package:jualin/utils/api_endpoints.dart';

class DetailedItemController extends GetxController {
  var item = <String, dynamic>{}.obs;
  var user = <String, dynamic>{}.obs;
  var isWishlisted = false.obs;
  var isLoadingWishlist = false.obs;
  var isLoading = false.obs;
  WishlistController wishlistController = Get.put(WishlistController());
  TransactionsController transactionsController =
      Get.put(TransactionsController());

  Future<void> fetchUserDetails() async {
    isLoading.value = true;
    var secureStorage = FlutterSecureStorage();

    Uri url = Uri.parse(ApiEndpoints.getUserById(item['user_id']));

    try {
      String? token = await secureStorage.read(key: 'token');
      var response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
      var json = jsonDecode(response.body);

      if (response.statusCode != 200 || !json['status']) {
        throw json['message'];
      }

      user.value = json['data'];
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

  void toggleWishlist() async {
    isLoadingWishlist.value = true;
    var secureStorage = FlutterSecureStorage();
    String? token = await secureStorage.read(key: 'token');

    try {
      if (isWishlisted.value) {
        var url = Uri.parse(ApiEndpoints.removeWishlistByItemId(item['id']));

        final response = await http.delete(
          url,
          headers: {'Authorization': 'Bearer $token'},
        );

        final json = jsonDecode(response.body);
        if (!json['status']) throw json['message'];

        wishlistController.wishlists.removeWhere((e) => e['id'] == item['id']);
      } else {
        final url = Uri.parse(ApiEndpoints.addWishlist);

        final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
          body: {'item_id': item['id'].toString()},
        );

        final json = jsonDecode(response.body);
        if (!json['status']) throw json['message'];

        wishlistController.wishlists.add(item);
      }

      isWishlisted.value = !isWishlisted.value;
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.error,
        colorText: AppColors.neutral10,
      );
    } finally {
      isLoadingWishlist.value = false;
    }
  }

  Future<void> buyyItem() async {
    final storage = const FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    final itemId = item['id'];

    try {
      final response = await http.post(
        Uri.parse(ApiEndpoints.buyItems),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'item_id': itemId}),
      );

      final json = jsonDecode(response.body);

      if (response.statusCode == 201 && json['status'] == true) {
        Get.snackbar(
          'Success',
          'Item added to pending purchases!',
          backgroundColor: AppColors.success,
          colorText: AppColors.neutral10,
        );
        Get.offAllNamed(Routes.DASHBOARD, arguments: {'index': 2});
        transactionsController.fetchTransactions();
      } else {
        throw json['message'];
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
    item.value = Get.arguments['item'];
    isWishlisted.value =
        wishlistController.wishlists.any((e) => e['id'] == item['id']);
    fetchUserDetails();
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
