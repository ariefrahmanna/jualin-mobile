import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jualin/app/routes/app_pages.dart';
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
            onPressed: () {
              Get.toNamed(Routes.MY_ACCOUNT);
            },
            icon: const Icon(Icons.person_outline, color: text),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Recently Viewed Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recently Viewed',
                    style: TextStyle(
                      color: text,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('See More'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 220,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      buildRecentlyViewedItem(
                        image: 'assets/images/yellow-chair.png',
                        title: 'Kursi Kuning',
                        price: 'Rp 499.000',
                      ),
                      buildRecentlyViewedItem(
                        image: 'assets/images/kursi_abu.jpg',
                        title: 'Kursi DPR',
                        price: 'Rp 999.000',
                      ),
                      buildRecentlyViewedItem(
                        image: 'assets/images/keyboard.png',
                        title: 'Mechanical Keyboard',
                        price: 'Rp 500.000',
                      ),
                      buildRecentlyViewedItem(
                        image: 'assets/images/plushies.png',
                        title: 'Pikachu Plush',
                        price: 'Rp 400.000',
                      ),
                      // Add more fixed items here
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Find by Categories Section
              const Text(
                'Find by Categories',
                style: TextStyle(
                  color: text,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 3 / 2,
                children: [
                  buildCategoryItem(
                    icon: Icons.devices_other,
                    label: 'Electronics',
                    color: Color(0xFFE2F3EC),
                    onTap: () {
                      Get.toNamed(
                        Routes.ITEM_BY_CATEGORY,
                        arguments: {
                          'category': 'Electronics',
                        },
                      );
                    },
                  ),
                  buildCategoryItem(
                    icon: Icons.kitchen,
                    label: 'Appliances',
                    color: Color(0xFFE3EAFE),
                    onTap: () {
                      Get.toNamed(
                        Routes.ITEM_BY_CATEGORY,
                        arguments: {
                          'category': 'Appliances',
                        },
                      );
                    },
                  ),
                  buildCategoryItem(
                    icon: Icons.chair,
                    label: 'Furniture',
                    color: Color(0xFFFFF1CF),
                    onTap: () {
                      Get.toNamed(
                        Routes.ITEM_BY_CATEGORY,
                        arguments: {
                          'category': 'Furniture',
                        },
                      );
                    },
                  ),
                  buildCategoryItem(
                    icon: Icons.more_horiz,
                    label: 'See More',
                    color: neutral50,
                    onTap: () {
                      // Aksi untuk "See More"
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for Recently Viewed Item
  Widget buildRecentlyViewedItem({
    required String image,
    required String title,
    required String price,
  }) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          Routes.DETAILED_ITEM,
          arguments: {
            'title': title,
            'price': price,
            'description': 'hihi',
            'imagePath': image,
          },
        );
      },
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: neutral10,
          boxShadow: [
            BoxShadow(
              color: neutral50,
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                image,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: text,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: const TextStyle(
                      color: text,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for Category Item
  Widget buildCategoryItem({
    required IconData icon,
    required String label,
    required Color color,
    VoidCallback? onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: primaryColor),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  color: text,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [
    'Meja',
    'Kursi',
    'Sofa',
    'Gitar',
    'Pokemon',
    'Keyboard',
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var item in searchTerms) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var item in searchTerms) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}
