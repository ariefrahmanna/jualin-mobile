import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_item_controller.dart';

class EditItemView extends GetView<EditItemController> {
  const EditItemView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EditItemView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EditItemView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
