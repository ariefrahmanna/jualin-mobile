import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jualin/app/routes/app_pages.dart';
import 'package:jualin/app/themes/colors.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Implement authentication
    Future.delayed(const Duration(seconds: 5)).then((value) {
      Get.offAllNamed(Routes.LOGIN);
    });

    return Scaffold(
      backgroundColor: neutral10,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo-2x.png',
              scale: 2,
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
