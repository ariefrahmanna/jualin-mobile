import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/recently_viewed_controller.dart';

class RecentlyViewedView extends GetView<RecentlyViewedController> {
  const RecentlyViewedView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RecentlyViewedView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RecentlyViewedView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
