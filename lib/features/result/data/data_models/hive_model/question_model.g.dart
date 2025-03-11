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
      id: fields[0] as dynamic,
      examID: fields[1] as dynamic,
      questionID: fields[2] as dynamic,
      question: fields[3] as dynamic,
      answes: fields[4] as dynamic,
      correctAnswer: fields[5] as dynamic,
      userAnswer: fields[6] as dynamic,
      duration: fields[7] as dynamic,
      isCompleted: fields[8] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, QuestionModelHive obj) {
    writer
      ..writeByte(9)
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
      ..write(obj.isCompleted);
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
