import 'package:get/get.dart';

import '../../core/services/api_service.dart';
import '../models/questionnaire_model.dart';


class QuestionnaireRepository {
  final ApiService _apiService = Get.find<ApiService>();

  Future<List<QuestionnaireModel>> getQuestionnaires() async {
    try {
      return await _apiService.getQuestionnaires();
    } catch (e) {
      rethrow;
    }
  }

  Future<QuestionnaireModel> getQuestionnaireById(String id) async {
    try {
      return await _apiService.getQuestionnaireById(id);
    } catch (e) {
      rethrow;
    }
  }
}