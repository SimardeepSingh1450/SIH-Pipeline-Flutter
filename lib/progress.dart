import 'package:hive/hive.dart';

part 'progress.g.dart'; // Generated file

@HiveType(typeId: 1)
class Progress extends HiveObject {
  @HiveField(0)
  String? _id;

  @HiveField(1)
  int? workerID;

  @HiveField(2)
  int? superVisorID;

  @HiveField(3)
  String? workerName;

  @HiveField(4)
  String? superVisorName;

  @HiveField(5)
  String? pipeLocationID;

  @HiveField(6)
  int? currentProgressPercent;

  @HiveField(7)
  bool? stageOne;

  @HiveField(8)
  bool? stageTwo;

  @HiveField(9)
  bool? stageThree;

  @HiveField(10)
  bool? stageFour;

  @HiveField(11)
  bool? stageFive;
}
