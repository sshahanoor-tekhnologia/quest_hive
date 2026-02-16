import 'package:get/get.dart';

import '../../core/services/storage_service.dart';
import '../../data/models/draft_model.dart';
import '../../data/models/questionnaire_model.dart';
import '../auth/auth_controller.dart';



class QuestionnaireController extends GetxController {
  final StorageService _storageService = Get.find();
  final AuthController _authController = Get.find();

  late QuestionnaireModel questionnaire;

  final RxMap<String, String> selectedAnswers =
      <String, String>{}.obs;

  final RxBool isSubmitting = false.obs;
  final RxBool isDraftRestored = false.obs;

  @override
  void onInit() {
    super.onInit();
    questionnaire = Get.arguments;
    _restoreDraft();
  }

  void _restoreDraft() {
    final userId = _authController.currentUser.value?.id ?? '';
    if (userId.isEmpty) return;

    final draft =
    _storageService.getDraft(userId, questionnaire.id);

    if (draft == null) return;

    final validIds =
    questionnaire.questions.map((q) => q.id).toSet();

    final filtered = <String, String>{};

    draft.answers.forEach((qid, ans) {
      if (validIds.contains(qid)) {
        filtered[qid] = ans;
      }
    });

    selectedAnswers.value = filtered;

    if (filtered.isNotEmpty) {
      isDraftRestored.value = true;
    }
  }

  void selectAnswer(String questionId, String answer) {
    selectedAnswers[questionId] = answer;
    _saveDraft();
  }

  bool isAnswerSelected(String qId, String answer) {
    return selectedAnswers[qId] == answer;
  }

  void _saveDraft() {
    final userId = _authController.currentUser.value?.id ?? '';
    if (userId.isEmpty) return;

    final draft = DraftModel(
      id: '${userId}_${questionnaire.id}',
      questionnaireId: questionnaire.id,
      userId: userId,
      answers: Map<String, String>.from(selectedAnswers),
      lastUpdated: DateTime.now(),
    );

    _storageService.saveDraft(draft);
  }
  Future<void> submitQuestionnaire() async {
    if (selectedAnswers.isEmpty) {
      Get.snackbar(
        'No Answers',
        'Please answer at least one question.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isSubmitting.value = true;

    try {
      await Future.delayed(const Duration(seconds: 1));

      final userId =
          _authController.currentUser.value?.id ?? '';

      _storageService.deleteDraft(
          userId, questionnaire.id);
      Get.back();
      Get.snackbar(
        'Success',
        'Submitted successfully',
        snackPosition: SnackPosition.BOTTOM,
      );

    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  bool areAllQuestionsAnswered() {
    return questionnaire.questions
        .every((q) => selectedAnswers.containsKey(q.id));
  }

  int getAnsweredCount() => selectedAnswers.length;

  int getTotalQuestions() => questionnaire.questions.length;

  void clearDraft() {
    final userId = _authController.currentUser.value?.id ?? '';
    _storageService.deleteDraft(userId, questionnaire.id);
    selectedAnswers.clear();
  }
}
