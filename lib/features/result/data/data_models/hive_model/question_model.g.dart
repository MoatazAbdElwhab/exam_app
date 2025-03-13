// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionModelHiveAdapter extends TypeAdapter<QuestionModelHive> {
  @override
  final int typeId = 0;

  @override
  QuestionModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestionModelHive(
      id: fields[0] as String,
      examID: fields[1] as String,
      questionID: fields[2] as String,
      question: fields[3] as String,
      answes: (fields[4] as List).cast<String>(),
      correctAnswer: fields[5] as String,
      duration: fields[7] as int,
      isCompleted: fields[8] as bool,
      examName: fields[9] as String?,
      iconUrl: fields[10] as String?,
      examTitle: fields[11] as String?,
      userAnswer: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, QuestionModelHive obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.examID)
      ..writeByte(2)
      ..write(obj.questionID)
      ..writeByte(3)
      ..write(obj.question)
      ..writeByte(4)
      ..write(obj.answes)
      ..writeByte(5)
      ..write(obj.correctAnswer)
      ..writeByte(6)
      ..write(obj.userAnswer)
      ..writeByte(7)
      ..write(obj.duration)
      ..writeByte(8)
      ..write(obj.isCompleted)
      ..writeByte(9)
      ..write(obj.examName)
      ..writeByte(10)
      ..write(obj.iconUrl)
      ..writeByte(11)
      ..write(obj.examTitle);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
