import 'package:get/get.dart';
import '../../core/services/api_service.dart';
import '../../core/services/location_service.dart';
import '../../core/services/storage_service.dart';
import '../models/submission_model.dart';

class SubmissionRepository {
  final ApiService _apiService = Get.find<ApiService>();
  final StorageService _storageService = Get.find<StorageService>();
  final LocationService _locationService = Get.find<LocationService>();

  Future<void> submitQuestionnaire({
    required String questionnaireId,
    required String questionnaireName,
    required Map<int, String> answers,
    required String userId,
  }) async {
    try {
      // Get current location
      final position = await _locationService.getCurrentLocation();

      // Create submission
      final submission = SubmissionModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        questionnaireId: questionnaireId,
        questionnaireName: questionnaireName,
        answers: answers,
        submissionDate: DateTime.now(),
        latitude: position?.latitude,
        longitude: position?.longitude,
        userId: userId,
      );

      // Save offline (primary storage)
      await _storageService.saveSubmission(submission);

      // Optionally sync to API (best effort)
      try {
        await _apiService.submitQuestionnaire(submission.toJson());
      } catch (e) {
        print('Could not sync to API: $e');
        // Continue - offline storage is what matters
      }
    } catch (e) {
      rethrow;
    }
  }

  List<SubmissionModel> getSubmissionsForUser(String userId) {
    return _storageService.getSubmissionsForUser(userId);
  }

  int getTotalSubmissionsCount(String userId) {
    return _storageService.getTotalSubmissionsCount(userId);
  }
}