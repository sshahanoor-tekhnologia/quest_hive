import 'package:get/get.dart';
import '../../data/models/questionnaire_model.dart';
import '../../data/models/user_model.dart';
import 'dio_service.dart';
import '../../app/constants/constants.dart';

class ApiService extends GetxService {
  final DioService _dioService = Get.find<DioService>();

  Future<ApiService> init() async {
    return this;
  }

  // Authentication APIs
  Future<UserModel> register(String email, String password) async {
    try {
      final response = await _dioService.post(
        '${Constant.baseUrl}/users',
        {
          'email': email,
          'password': password,
          'createdAt': DateTime.now().toIso8601String(),
        },
      );

      return UserModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> login(String email, String password) async {
    try {
      // In MockAPI, we'll get all users and find matching credentials
      final response = await _dioService.get('${Constant.baseUrl}/users');
      final users = (response.data as List)
          .map((user) => UserModel.fromJson(user))
          .toList();

      final user = users.firstWhereOrNull(
            (u) => u.email.toLowerCase() == email.toLowerCase(),
      );

      if (user == null) {
        throw 'User not found';
      }

      // In a real app, you'd verify password on backend
      // For MockAPI, we're simulating login
      return user;
    } catch (e) {
      rethrow;
    }
  }

  // Questionnaire APIs
  Future<List<QuestionnaireModel>> getQuestionnaires() async {
    try {
      final response = await _dioService.get('${Constant.baseUrl}/Questionnaires');
      return (response.data as List)
          .map((q) => QuestionnaireModel.fromJson(q))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<QuestionnaireModel> getQuestionnaireById(String id) async {
    try {
      final response = await _dioService.get('${Constant.baseUrl}/questionnaires/$id');
      return QuestionnaireModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  // Optional: Submit to MockAPI (can be skipped if offline-only)
  Future<void> submitQuestionnaire(Map<String, dynamic> submissionData) async {
    try {
      await _dioService.post('${Constant.baseUrl}/submissions', submissionData);
    } catch (e) {
      print('Error submitting to API: $e');
      // Don't throw - offline storage is primary
    }
  }
}