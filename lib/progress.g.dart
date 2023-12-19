// progress.g.dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress.dart';

@HiveType(typeId: 1)
class ProgressAdapter extends TypeAdapter<Progress> {
  @override
  final int typeId = 1;

  @override
  Progress read(BinaryReader reader) {
    return Progress()
      .._id = reader.read()
      ..workerID = reader.read()
      ..superVisorID = reader.read()
      ..workerName = reader.read()
      ..superVisorName = reader.read()
      ..pipeLocationID = reader.read()
      ..currentProgressPercent = reader.read()
      ..stageOne = reader.read()
      ..stageTwo = reader.read()
      ..stageThree = reader.read()
      ..stageFour = reader.read()
      ..stageFive = reader.read();
  }

  @override
  void write(BinaryWriter writer, Progress obj) {
    writer
      ..write(obj._id)
      ..write(obj.workerID)
      ..write(obj.superVisorID)
      ..write(obj.workerName)
      ..write(obj.superVisorName)
      ..write(obj.pipeLocationID)
      ..write(obj.currentProgressPercent)
      ..write(obj.stageOne)
      ..write(obj.stageTwo)
      ..write(obj.stageThree)
      ..write(obj.stageFour)
      ..write(obj.stageFive);
  }
}
