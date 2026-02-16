import 'package:get/get.dart';
import '../../../data/models/submission_model.dart';
import '../../data/repositories/submission_respository.dart';
import '../auth/auth_controller.dart';

class ProfileController extends GetxController {
  final SubmissionRepository _submissionRepository = SubmissionRepository();
  final AuthController _authController = Get.find<AuthController>();

  final RxList<SubmissionModel> submissions = <SubmissionModel>[].obs;
  final RxInt totalSubmissions = 0.obs;
  final RxString userEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() {
    final user = _authController.currentUser.value;
    if (user != null) {
      userEmail.value = user.email;
      submissions.value = _submissionRepository.getSubmissionsForUser(user.id);
      totalSubmissions.value =
          _submissionRepository.getTotalSubmissionsCount(user.id);
    }
  }

  void refreshData() {
    loadUserData();
  }
}