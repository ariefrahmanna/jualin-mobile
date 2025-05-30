import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/sell_items_controller.dart';

class SellItemsView extends GetView<SellItemsController> {
  const SellItemsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SellItemsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SellItemsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
