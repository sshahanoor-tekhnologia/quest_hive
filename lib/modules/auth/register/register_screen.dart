import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quest_hive/modules/auth/register/register_controller.dart';

class RegisterScreen extends StatelessWidget {
  final RegisterController controller = Get.put(RegisterController());

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF1A237E);

    return Scaffold(
      backgroundColor: const Color(0xffF4F6FB),
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text("Create Account"),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black12)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.person_add, size: 70, color: primary),

                  const SizedBox(height: 24),

                  _input(controller.emailController, "Email", Icons.email),

                  const SizedBox(height: 14),

                  _input(
                    controller.passwordController,
                    "Password",
                    Icons.lock,
                    obscure: true,
                  ),

                  const SizedBox(height: 14),

                  _input(
                    controller.confirmPasswordController,
                    "Confirm Password",
                    Icons.lock_outline,
                    obscure: true,
                  ),

                  const SizedBox(height: 24),

                  Obx(
                    () => ElevatedButton(
                      onPressed: controller.loading.value
                          ? null
                          : controller.register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: controller.loading.value
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text("Register"),
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextButton(
                    onPressed: Get.back,
                    child: const Text("Already have account? Login"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _input(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool obscure = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
