import 'package:flutter/material.dart';

import 'package:jualin/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:jualin/app/themes/colors.dart';

import '../controllers/my_account_controller.dart';

class MyAccountView extends GetView<MyAccountController> {
  const MyAccountView({super.key});
  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.neutral70,
        ),
      ),
    );
  }

  Widget accountItem({
    required IconData icon,
    required String label,
    Color iconColor = AppColors.text,
    Color textColor = AppColors.text,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: AppColors.neutral10,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.neutral50),
      ),
      child: Material(
        color: AppColors.neutral10,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            child: Row(
              children: [
                Icon(icon, color: iconColor, size: 24),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 16, color: textColor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral10,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "My Account",
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
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.black),
            onPressed: () {},
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(24),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.neutral10,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.neutral50),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.secondary,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Obx(() => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.fullname.value,
                                style: const TextStyle(
                                  color: AppColors.text,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                controller.email.value,
                                style: const TextStyle(
                                  color: AppColors.neutral70,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          )),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.toNamed(Routes.EDIT_ACCOUNT, arguments: {
                          'username': controller.username.value,
                          'fullname': controller.fullname.value,
                          'email': controller.email.value,
                          'contactNumber': controller.contactNumber.value,
                        });
                      },
                      icon: const Icon(Icons.edit_outlined),
                    ),
                  ],
                ),
              ),
              sectionTitle("General"),
              accountItem(
                icon: Icons.receipt,
                label: "Transaction",
              ),
              accountItem(
                icon: Icons.favorite_border,
                label: "Wishlist",
              ),
              accountItem(
                icon: Icons.chat_bubble_outline,
                label: "Chats",
              ),
              accountItem(
                icon: Icons.credit_card_outlined,
                label: "Payment Methods",
              ),
              accountItem(
                icon: Icons.place_outlined,
                label: "My Address",
              ),
              accountItem(
                icon: Icons.lock_outline,
                label: "Security",
              ),
              sectionTitle("Help"),
              accountItem(
                icon: Icons.person_outline,
                label: "Get in Touch With Us",
              ),
              const SizedBox(height: 20),
              accountItem(
                icon: Icons.logout,
                label: "Logout",
                iconColor: AppColors.error,
                textColor: AppColors.error,
                onTap: () {
                  controller.logout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
