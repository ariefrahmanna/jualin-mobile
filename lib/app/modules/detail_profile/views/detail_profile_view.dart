import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jualin/app/modules/detail_profile/controllers/detail_profile_controller.dart';
import 'package:jualin/app/themes/colors.dart';
import 'package:jualin/app/themes/fonts.dart';
import 'package:jualin/widgets/item_card.dart';
import 'package:jualin/app/routes/app_pages.dart';

class DetailProfileView extends GetView<DetailProfileController> {
  const DetailProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral20,
      appBar: AppBar(
        backgroundColor: AppColors.neutral20,
        elevation: 0,
        title: const Text(
          "User Profile",
          style: TextStyle(
            color: AppColors.text,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppColors.text,
          onPressed: () {
            Get.back();
          },
        ),
        iconTheme: IconThemeData(
          color: AppColors.text,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.secondary,
                  child: const Icon(
                    Icons.person,
                    size: 40,
                    color: AppColors.neutral10,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      controller.user['fullname'],
                      style: AppFonts.h2.bold,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.neutral30,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.phone,
                            size: 16,
                            color: AppColors.neutral70,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            controller.user['contact_number'],
                            style: AppFonts.h4.bold,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text("Items", style: AppFonts.h2.bold),
              const SizedBox(height: 8),
              Obx(
                () {
                  if (controller.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  }
                  if (controller.items.isEmpty) {
                    return Center(
                      child: Text(
                        'No items found in this category',
                        style: TextStyle(
                          color: AppColors.neutral70,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.68,
                    ),
                    itemCount: controller.items.length,
                    itemBuilder: (context, index) {
                      final item = controller.items[index];
                      return ItemCard(
                        item: item,
                        onTap: () {
                          Get.toNamed(Routes.DETAILED_ITEM, arguments: item);
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
