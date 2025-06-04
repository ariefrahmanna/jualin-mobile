import 'package:flutter/material.dart';

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
          color: neutral70,
        ),
      ),
    );
  }

  Widget accountItem({
    required IconData icon,
    required String label,
    Color iconColor = text,
    Color textColor = text,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: BoxDecoration(
        color: neutral10,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: neutral50),
      ),
      child: Material(
        color: neutral10,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
      backgroundColor: neutral10,
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: neutral10),
        elevation: 0,
        title: const Text(
          "My Account",
          style: TextStyle(
            color: neutral10,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
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
                  color: neutral10,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: neutral50),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/images/profile.jpg"),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Oliver Sartono",
                            style: TextStyle(
                              color: text,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "oliver.sartono@mail.com",
                            style: TextStyle(
                              color: neutral70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit_outlined,
                        color: text,
                        size: 20,
                      ),
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
                iconColor: errors,
                textColor: errors,
                onTap: () => {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
