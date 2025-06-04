import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/term_condition_controller.dart';

class TermConditionView extends GetView<TermConditionController> {
  const TermConditionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TermConditionView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TermConditionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
