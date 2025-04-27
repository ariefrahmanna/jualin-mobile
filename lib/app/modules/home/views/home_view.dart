import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jualin/app/themes/colors.dart'; // Import warna yang sudah kamu buat

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral10,
      appBar: AppBar(
        backgroundColor: neutral10,
        elevation: 0,
        title: GestureDetector(
          onTap: () {
            showSearch(
              context: context,
              delegate: CustomSearchDelegate(),
            );
          },
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: neutral50,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.search, color: text),
                ),
                const Expanded(
                  child: Text(
                    'Search items',
                    style: TextStyle(color: text, fontSize: 16),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.camera_alt_outlined, color: text),
                ),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: text),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person_outline, color: text),
          ),
        ],
      ),
    );
  }
}
