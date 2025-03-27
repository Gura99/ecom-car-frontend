import 'package:crud/controllers/auth_controller.dart';
import 'package:crud/controllers/token_service.dart';
import 'package:crud/pages/home_page.dart';
 
import 'package:crud/pages/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pages/sign_up_page.dart'; // Import your SignUpPage

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure async operations work
  Get.put(TokenService());
  Get.put(AuthController()); // Register AuthController
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product App',
      initialRoute: '/home',
      getPages: [
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/sign-up', page: () => SignUpPage()),
        GetPage(name: '/sign-in', page: () => SignInPage()),
      ],
    );
  }
}
