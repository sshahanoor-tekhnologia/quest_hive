import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../data/models/draft_model.dart';
import '../../data/models/submission_model.dart';
import '../../data/models/user_model.dart';



class StorageService extends GetxService {
  static const String userBoxName = 'userBox';
  static const String submissionsBoxName = 'submissionsBox';
  static const String sessionBoxName = 'sessionBox';
  static const String draftsBoxName = 'draftsBox';

  late Box<UserModel> _userBox;
  late Box<SubmissionModel> _submissionsBox;
  late Box _sessionBox;
  late Box<DraftModel> _draftsBox;

  Future<StorageService> init() async {
    await Hive.initFlutter();

    // Register adapters
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserModelAdapter());
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(SubmissionModelAdapter());
    }
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(DraftModelAdapter());
    }

    // Open boxes
    _userBox = await Hive.openBox<UserModel>(userBoxName);
    _submissionsBox = await Hive.openBox<SubmissionModel>(submissionsBoxName);
    _sessionBox = await Hive.openBox(sessionBoxName);
    _draftsBox = await Hive.openBox<DraftModel>(draftsBoxName);

    return this;
  }

  // User Session Methods
  Future<void> saveUserSession(UserModel user) async {
    await _userBox.put('currentUser', user);
    await _sessionBox.put('isLoggedIn', true);
    await _sessionBox.put('userId', user.id);
  }

  UserModel? getCurrentUser() {
    return _userBox.get('currentUser');
  }

  bool isLoggedIn() {
    return _sessionBox.get('isLoggedIn', defaultValue: false);
  }

  Future<void> clearSession() async {
    await _userBox.delete('currentUser');
    await _sessionBox.delete('isLoggedIn');
    await _sessionBox.delete('userId');
  }

  // Submission Methods
  Future<void> saveSubmission(SubmissionModel submission) async {
    await _submissionsBox.put(submission.id, submission);
  }

  List<SubmissionModel> getSubmissionsForUser(String userId) {
    return _submissionsBox.values
        .where((submission) => submission.userId == userId)
        .toList()
      ..sort((a, b) => b.submissionDate.compareTo(a.submissionDate));
  }

  int getTotalSubmissionsCount(String userId) {
    return _submissionsBox.values
        .where((submission) => submission.userId == userId)
        .length;
  }

  Future<void> clearAllSubmissions() async {
    await _submissionsBox.clear();
  }

  // Draft Methods
  Future<void> saveDraft(DraftModel draft) async {
    final key = '${draft.userId}_${draft.questionnaireId}';
    await _draftsBox.put(key, draft);
    print('✅ Draft saved: $key with ${draft.answers.length} answers');
  }

  DraftModel? getDraft(String userId, String questionnaireId) {
    final key = '${userId}_$questionnaireId';
    final draft = _draftsBox.get(key);
    if (draft != null) {
      print('✅ Draft found: $key with ${draft.answers.length} answers');
    }
    return draft;
  }

  Future<void> deleteDraft(String userId, String questionnaireId) async {
    final key = '${userId}_$questionnaireId';
    await _draftsBox.delete(key);
    print('✅ Draft deleted: $key');
  }

  List<DraftModel> getAllDraftsForUser(String userId) {
    return _draftsBox.values
        .where((draft) => draft.userId == userId)
        .toList()
      ..sort((a, b) => b.lastUpdated.compareTo(a.lastUpdated));
  }

  Future<void> clearAllDrafts() async {
    await _draftsBox.clear();
  }

  // General cleanup
  Future<void> dispose() async {
    await _userBox.close();
    await _submissionsBox.close();
    await _sessionBox.close();
    await _draftsBox.close();
  }
}