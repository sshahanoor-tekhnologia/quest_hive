import 'package:hive/hive.dart';

part 'submission_model.g.dart';

@HiveType(typeId: 3)
class SubmissionModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String questionnaireId;

  @HiveField(2)
  final String questionnaireName;

  @HiveField(3)
  final Map<int, String> answers; // questionId -> selected answer

  @HiveField(4)
  final DateTime submissionDate;

  @HiveField(5)
  final double? latitude;

  @HiveField(6)
  final double? longitude;

  @HiveField(7)
  final String userId;

  SubmissionModel({
    required this.id,
    required this.questionnaireId,
    required this.questionnaireName,
    required this.answers,
    required this.submissionDate,
    this.latitude,
    this.longitude,
    required this.userId,
  });

  factory SubmissionModel.fromJson(Map<String, dynamic> json) {
    return SubmissionModel(
      id: json['id']?.toString() ?? '',
      questionnaireId: json['questionnaireId']?.toString() ?? '',
      questionnaireName: json['questionnaireName'] ?? '',
      answers: Map<int, String>.from(json['answers'] ?? {}),
      submissionDate: json['submissionDate'] != null
          ? DateTime.parse(json['submissionDate'])
          : DateTime.now(),
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      userId: json['userId']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questionnaireId': questionnaireId,
      'questionnaireName': questionnaireName,
      'answers': answers,
      'submissionDate': submissionDate.toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
      'userId': userId,
    };
  }
}