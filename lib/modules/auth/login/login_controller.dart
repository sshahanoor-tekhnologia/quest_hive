import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quest_hive/app/routes/app_routes.dart';

import '../auth_controller.dart';

class LoginController extends GetxController {
  final AuthController authController = Get.find();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RxBool loading = false.obs;

  Future<void> login() async {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      Get.snackbar("Error", "Enter email & password");
      return;
    }

    loading.value = true;

    try {
      await authController.login(
        emailController.text.trim(),
        passwordController.text,
      );

      Get.offAllNamed(AppRoutes.HOME);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }

    loading.value = false;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
