import 'package:get/get.dart';
import '../../data/models/questionnaire_model.dart';
import '../../data/repositories/questionnair_respository.dart';

class HomeController extends GetxController {
  final QuestionnaireRepository _questionnaireRepository =
  QuestionnaireRepository();

  final RxList<QuestionnaireModel> questionnaires =
      <QuestionnaireModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchQuestionnaires();
  }

  Future<void> fetchQuestionnaires() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final data = await _questionnaireRepository.getQuestionnaires();
      questionnaires.value = data;
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to load questionnaires: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshQuestionnaires() async {
    await fetchQuestionnaires();
  }
}