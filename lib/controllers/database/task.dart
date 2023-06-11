import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
class Task {
  @HiveField(0)
  String title;

  @HiveField(1)
  String? description;

  @HiveField(2)
  int importance;

  @HiveField(3)
  DateTime? date;

  @HiveField(4)
  DateTime? time;

  @HiveField(5)
  int typeOfDate;

  @HiveField(6)
  int category;

  @HiveField(7)
  int? localId;

  @HiveField(8)
  DateTime? doneTime;

  Task(
      {required this.title,
      this.description,
      required this.importance,
      this.date,
      this.time,
      required this.typeOfDate,
      required this.category,
      this.localId,
      this.doneTime});
}
