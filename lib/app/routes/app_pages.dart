import 'package:get/get.dart';
import '../../modules/auth/auth_controller.dart';
import '../../modules/auth/login/login_screen.dart';
import '../../modules/auth/register/register_screen.dart';
import '../../modules/home/home_controller.dart';
import '../../modules/home/home_screen.dart';
import '../../modules/profile/profile_controller.dart';
import '../../modules/profile/profile_screen.dart';
import '../../modules/questionnaires/questionnaires_controller.dart';
import '../../modules/questionnaires/questionnaires_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
    ),
    GetPage(
      name: AppRoutes.REGISTER,
      page: () => RegisterScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomeScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HomeController>(() => HomeController());
      }),
    ),
    GetPage(
      name: AppRoutes.QUESTIONNAIRE,
      page: () => QuestionnaireScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<QuestionnaireController>(() => QuestionnaireController());
        Get.lazyPut<AuthController>(() => AuthController());
      }),
    ),
    GetPage(
      name: AppRoutes.PROFILE,
      page: () => ProfileScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ProfileController>(() => ProfileController());
      }),
    ),
  ];
}