import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class ProfilePage extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text(
                  authController.userName.value.isNotEmpty
                      ? authController.userName.value // ✅ Display saved name
                      : 'Guest User',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                authController.setUserName(''); // ✅ Clear user name
                Get.offAllNamed('/sign-in'); // Logout
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
