import 'package:get/get.dart';
import '../../core/services/api_service.dart';
import '../../core/services/storage_service.dart';
import '../models/user_model.dart';


class AuthRepository {
  ApiService get _apiService => Get.find<ApiService>();
  StorageService get _storageService => Get.find<StorageService>();

  Future<UserModel> register(String email, String password) async {
    try {
      final user = await _apiService.register(email, password);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> login(String email, String password) async {
    try {
      final user = await _apiService.login(email, password);
      await _storageService.saveUserSession(user);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await _storageService.clearSession();
  }

  UserModel? getCurrentUser() {
    return _storageService.getCurrentUser();
  }

  bool isLoggedIn() {
    return _storageService.isLoggedIn();
  }
}