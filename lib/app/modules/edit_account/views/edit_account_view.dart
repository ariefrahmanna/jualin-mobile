import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_account_controller.dart';

class EditAccountView extends GetView<EditAccountController> {
  const EditAccountView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EditAccountView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EditAccountView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
