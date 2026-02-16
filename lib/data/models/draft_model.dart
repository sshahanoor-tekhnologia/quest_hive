import 'package:hive/hive.dart';

part 'draft_model.g.dart';

@HiveType(typeId: 4)
class DraftModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String questionnaireId;

  @HiveField(2)
  final String userId;

  @HiveField(3)
  final Map<String, String> answers;

  @HiveField(4)
  final DateTime lastUpdated;

  DraftModel({
    required this.id,
    required this.questionnaireId,
    required this.userId,
    required this.answers,
    required this.lastUpdated,
  });
}
