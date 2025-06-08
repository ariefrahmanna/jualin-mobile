import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_item_controller.dart';

class AddItemView extends GetView<AddItemController> {
  const AddItemView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddItemView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AddItemView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
