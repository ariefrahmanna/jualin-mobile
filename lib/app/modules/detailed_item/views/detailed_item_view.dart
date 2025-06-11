import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jualin/app/routes/app_pages.dart';
import 'package:jualin/utils/currency_formatter.dart';
import '../controllers/detailed_item_controller.dart';
import 'package:jualin/app/themes/colors.dart';
import 'package:jualin/app/themes/fonts.dart';

class DetailedItemView extends GetView<DetailedItemController> {
  const DetailedItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral20,
      appBar: AppBar(
        backgroundColor: AppColors.neutral20,
        elevation: 0,
        title: const Text(
          "Product Detail",
          style: TextStyle(
            color: AppColors.text,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: Image.network(
                controller.item['image_url'],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.broken_image);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.item['name'],
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      CurrencyFormatter.toRupiah(controller.item['price']),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.success,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      controller.item['description'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.neutral70,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Meet the Seller",
                      style: AppFonts.h4.bold,
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          Routes.DETAIL_PROFILE,
                          arguments: {'user': controller.user},
                        );
                      },
                      child: Obx(
                        () {
                          if (controller.isLoading.value) {
                            return Container(
                              width: 150,
                              height: 20,
                              decoration: BoxDecoration(
                                color: AppColors.neutral40,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            );
                          }
                          return Text(
                            controller.user['fullname'],
                            style: AppFonts.userLink,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              color: AppColors.neutral10,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 1,
                )
              ],
            ),
            child: Row(
              children: [
                Container(
                  decoration: ShapeDecoration(
                    color: AppColors.neutral10,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Obx(
                    () {
                      return IconButton(
                        onPressed: () {
                          if (!controller.isLoadingWishlist.value) {
                            controller.toggleWishlist();
                          }
                        },
                        icon: Icon(
                          controller.isWishlisted.value
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: AppColors.primary,
                          size: 30,
                        ),
                      );
                    },
                  ),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.defaultDialog(
                        title: 'Confirm Purchase',
                        middleText: 'Are you sure you want to buy this item?',
                        textCancel: 'Cancel',
                        textConfirm: 'Buy',
                        confirmTextColor: Colors.white,
                        buttonColor: AppColors.primary,
                        onConfirm: () {
                          Get.back();
                          controller.buyyItem();
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                      decoration: ShapeDecoration(
                        color: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Buy',
                        style: AppFonts.button.primary,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
