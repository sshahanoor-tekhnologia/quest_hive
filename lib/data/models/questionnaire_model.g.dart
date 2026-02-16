// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questionnaire_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionnaireModelAdapter extends TypeAdapter<QuestionnaireModel> {
  @override
  final int typeId = 1;

  @override
  QuestionnaireModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestionnaireModel(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      questions: (fields[3] as List).cast<QuestionModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, QuestionnaireModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.questions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionnaireModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
