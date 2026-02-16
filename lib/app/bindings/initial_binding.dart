import 'package:get/get.dart';
import '../../modules/auth/auth_controller.dart';




class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
  }
}