import 'package:get/get.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../app/routes/app_routes.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  final RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  void checkLoginStatus() {
    isLoggedIn.value = _authRepository.isLoggedIn();
    if (isLoggedIn.value) {
      currentUser.value = _authRepository.getCurrentUser();
    }
  }

  Future<UserModel> login(String email, String password) async {
    final user = await _authRepository.login(email, password);

    currentUser.value = user;
    isLoggedIn.value = true;

    return user;
  }

  Future<void> register(String email, String password) async {
    await _authRepository.register(email, password);
  }

  Future<void> logout() async {
    await _authRepository.logout();
    currentUser.value = null;
    isLoggedIn.value = false;

    Get.offAllNamed(AppRoutes.LOGIN);
  }
}
