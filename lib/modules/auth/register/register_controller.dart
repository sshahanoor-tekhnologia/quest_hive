import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth_controller.dart';

class RegisterController extends GetxController {
  final AuthController authController = Get.find();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  RxBool loading = false.obs;

  Future<void> register() async {
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirm = confirmPasswordController.text;

    if (email.isEmpty) {
      Get.snackbar("Error", "Email required");
      return;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar("Error", "Invalid email");
      return;
    }

    if (password.length < 6) {
      Get.snackbar("Error", "Password too short");
      return;
    }

    if (password != confirm) {
      Get.snackbar("Error", "Passwords do not match");
      return;
    }

    loading.value = true;

    try {
      await authController.register(email, password);
      Get.back();
      Get.snackbar(
        "Success",
        "Account created. Please login.",
      );

    } catch (e) {
      Get.snackbar("Error", e.toString());
    }

    loading.value = false;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
