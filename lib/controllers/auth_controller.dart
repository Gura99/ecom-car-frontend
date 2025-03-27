// import 'package:crud/controllers/token_service.dart';
import 'package:crud/controllers/token_service.dart';
import 'package:dio/dio.dart';
import '../config/app_config.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final Dio dio = Dio();
  var isLoading = false.obs;
  var userName = ''.obs;
  void setUserName(String name) {
    userName.value = name; // ✅ Set username
  }

  Future<bool> register(String name, String email, String password) async {
    try {
      final response = await dio.post(
        '${AppConfig.baseUrl}/register',
        data: {
          "name": name,
          "email": email,
          "password": password,
          "password_confirmation": password,
        },
      );

      if (response.data['success'] == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Register Error: $e"); // 🛑 Debug Error
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
  try {
    final response = await dio.post(
      '${AppConfig.baseUrl}/login',
      data: {
        "email": email,
        "password": password,
      },
    );

    if (response.statusCode == 200) {
      final token = response.data['token'];
      final userName = response.data['user']['name']; // ✅ Get user name from API

      final TokenService tokenService = Get.find<TokenService>();
      await tokenService.saveToken(token); // ✅ Save token

      final AuthController authController = Get.find<AuthController>();
      authController.setUserName(userName); // ✅ Save username

      Get.offAllNamed('/home');
      return true;
    }
    return false;
  } catch (e) {
    
    return false;
  }
}


  // Future<bool> logout() async {
  //   try {
  //     String? token = Get.find<TokenService>().getToken();
  //     final response = await dio.post(
  //       '${AppConfig.baseUrl}/logout',
  //       options: Options(
  //         headers: {"Authorization": "Bearer $token"},
  //       ),
  //     );

  //     if (response.statusCode == 200) {
  //       Get.find<TokenService>().removeToken();
  //       return true;
  //     }
  //     return false;
  //   } catch (e) {
  //     print("Logout Error: $e");
  //     return false;
  //   }
  // }
}
