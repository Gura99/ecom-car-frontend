import 'dart:ui';
import 'package:crud/pages/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class SignUpPage extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/mountain.jpg'), // Adjust path
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            _buildTextField(
                                "Full Name", Icons.person, nameController),
                            const SizedBox(height: 20),
                            _buildTextField(
                                "Email", Icons.email, emailController),
                            const SizedBox(height: 20),
                            _buildTextField(
                                "Password", Icons.lock, passwordController,
                                isObscure: true),
                            const SizedBox(height: 20),
                            _buildTextField("Confirm Password", Icons.lock,
                                confirmPasswordController,
                                isObscure: true),
                            const SizedBox(height: 20),
                            Center(
                              child: Obx(() => authController.isLoading.value
                                  ? const CircularProgressIndicator()
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 50, vertical: 15),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        backgroundColor: Colors.red,
                                      ),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          authController.isLoading.value =
                                              true; // Start loading
                                          bool success =
                                              await authController.register(
                                            nameController.text,
                                            emailController.text,
                                            passwordController.text,
                                          );

                                          authController.isLoading.value =
                                              false; // Stop loading

                                          if (success) {
                                            Get.snackbar(
                                                "Success", "Account Created!");

                                            // ⏳ Wait 2 seconds before navigating to Sign-In
                                            Future.delayed(
                                                const Duration(seconds: 2), () {
                                              Get.offAll(() => SignInPage());
                                            });
                                          } else {
                                            Get.snackbar("Error",
                                                "Failed to create an account");
                                          }
                                        }
                                      },
                                      child: const Text(
                                        'Sign Up',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    )),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: TextButton(
                                onPressed: () => Get.to(() => SignInPage()),
                                child: const Text(
                                  "Already have an account? Sign In",
                                  style: TextStyle(
                                      color: Colors.white,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      String label, IconData icon, TextEditingController controller,
      {bool isObscure = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isObscure,
          validator: (value) =>
              value == null || value.isEmpty ? "$label cannot be empty" : null,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.white),
            filled: true,
            fillColor: Colors.white.withOpacity(0.2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            hintText: 'Enter your $label',
            hintStyle: const TextStyle(color: Colors.white),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
