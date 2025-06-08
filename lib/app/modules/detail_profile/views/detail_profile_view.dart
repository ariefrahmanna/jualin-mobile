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
              // Profile picture placeholder
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.neutral70.withOpacity(0.2),
                  child: const Icon(
                    Icons.person,
                    size: 40,
                    color: AppColors.neutral70,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Username
              Text(
                '@${controller.user['username'] ?? ''}',
                style: AppFonts.h2.bold.copyWith(
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 8),
              // Fullname
              Text(
                controller.user['fullname'] ?? '',
                style: AppFonts.h2.regular.copyWith(
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 20),
              // ...existing code...
              const SizedBox(height: 20),
              Text("Items", style: AppFonts.h2.bold),
              const SizedBox(height: 8),
              controller.items.isEmpty
                  ? const Center(child: Text('No items'))
                  : GridView.builder(
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
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
