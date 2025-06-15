import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jualin/app/routes/app_pages.dart';
import 'package:jualin/app/themes/colors.dart';
import 'package:jualin/app/themes/fonts.dart';
import 'package:jualin/widgets/item_card.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
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
              color: AppColors.neutral10,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    Icons.search,
                    color: AppColors.primary,
                  ),
                ),
                const Expanded(
                  child: Text(
                    'Search items',
                    style: TextStyle(
                      color: AppColors.text,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.MY_ACCOUNT);
            },
            icon: Icon(
              Icons.person_outline,
              color: AppColors.neutral10,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchRecentlyAddedPreview();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Recently Viewed Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recently Added',
                      style: AppFonts.h2.bold,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.RECENTLY_ADDED);
                      },
                      child: Text(
                        'See More',
                        style: AppFonts.h5.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.recentlyAddedItems.length,
                      itemBuilder: (context, index) {
                        final item = controller.recentlyAddedItems[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: ItemCard(
                            item: item,
                            onTap: () {
                              Get.toNamed(
                                Routes.DETAILED_ITEM,
                                arguments: {
                                  'item': item,
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                }),

                const SizedBox(height: 24),

                // Find by Categories Section
                Text(
                  'Find by Categories',
                  style: AppFonts.h2.bold,
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
                      icon: Icons.gamepad,
                      label: 'Hobby',
                      color: AppColors.neutral50,
                      onTap: () {
                        Get.toNamed(
                          Routes.ITEM_BY_CATEGORY,
                          arguments: {
                            'category': 'Hobby',
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
          color: AppColors.neutral10,
          boxShadow: [
            BoxShadow(
              color: AppColors.neutral50,
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
                      color: AppColors.text,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: const TextStyle(
                      color: AppColors.text,
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
              Icon(icon, color: AppColors.primary),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.text,
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
  HomeController homeController = Get.find<HomeController>();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          showSuggestions(context);
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
    homeController.searchItems(query);
    return Obx(() {
      if (homeController.isSearching.value) {
        return Center(child: CircularProgressIndicator());
      }
      if (homeController.searchResults.isEmpty) {
        return Center(child: Text('No results found'));
      }
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Search results for: "$query"',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.7,
                ),
                itemCount: homeController.searchResults.length,
                itemBuilder: (context, index) {
                  var item = homeController.searchResults[index];
                  return ItemCard(
                    item: item,
                    onTap: () {
                      Get.toNamed(
                        Routes.DETAILED_ITEM,
                        arguments: {
                          'item': item,
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    homeController.searchSuggestions(query);
    return Obx(() {
      final suggestions = homeController.filteredSuggestions;

      if (suggestions.isEmpty) {
        return Padding(
          padding: EdgeInsets.all(16),
          child: Text(''),
        );
      }

      return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final item = suggestions[index];
          return ListTile(
            title: Text(item['name']),
            onTap: () {
              query = item['name'];
              showResults(context);
            },
          );
        },
      );
    });
  }
}
