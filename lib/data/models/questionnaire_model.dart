import 'package:hive/hive.dart';
import 'question_model.dart';

part 'questionnaire_model.g.dart';

@HiveType(typeId: 1)
class QuestionnaireModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final List<QuestionModel> questions;

  QuestionnaireModel({
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
  });

  factory QuestionnaireModel.fromJson(Map<String, dynamic> json) {
    return QuestionnaireModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      questions: (json['questions'] as List<dynamic>)
          .map((q) => QuestionModel.fromJson(q))
          .toList(),
    );
  }
}
