import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/bindings/initial_binding.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'core/services/api_service.dart';
import 'core/services/dio_service.dart';
import 'core/services/location_service.dart';
import 'core/services/storage_service.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  Get.put(DioService(), permanent: true);
  Get.put(ApiService(), permanent: true);
  await Get.putAsync(() => StorageService().init(), permanent: true);
  Get.putAsync(() => LocationService().init(), permanent: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Questionnaire App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      initialBinding: InitialBinding(),
      getPages: AppPages.routes,
      initialRoute: _getInitialRoute(),
    );
  }

  String _getInitialRoute() {
    try {
      final storageService = Get.find<StorageService>();
      return storageService.isLoggedIn() ? AppRoutes.HOME : AppRoutes.LOGIN;
    } catch (e) {
      return AppRoutes.LOGIN;
    }
  }
}