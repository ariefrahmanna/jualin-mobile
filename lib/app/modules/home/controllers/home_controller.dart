import 'package:get/get.dart';
import 'package:jualin/app/modules/recently_added/controllers/recently_added_controller.dart';
import 'package:jualin/app/themes/colors.dart';

class HomeController extends GetxController {
  var recentlyAddedItems = [].obs;
  var isLoading = false.obs;

  var recentlyAddedController = Get.put(RecentlyAddedController());

  Future<void> fetchRecentlyAddedPreview() async {
    try {
      isLoading.value = true;
      await recentlyAddedController.fetchRecentlyAddedItems();

      // Ambil hanya 5 item sebagai preview
      recentlyAddedItems.value = recentlyAddedController.recentlyAddedItems.take(5).toList();
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

  @override
  void onInit() {
    super.onInit();
    fetchRecentlyAddedPreview();
  }
}
