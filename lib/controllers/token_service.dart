import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TokenService extends GetxService {
  final GetStorage storage = GetStorage();

  Future<void> saveToken(String token) async {
    await storage.write('auth_token', token);
  }

  Future<String?> getToken() async {
    return storage.read('auth_token');
  }

  Future<void> removeToken() async {
    await storage.remove('auth_token');
  }
}
