import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
class Task {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  int importance;

  @HiveField(3)
  DateTime date;

  @HiveField(4)
  int icon;

  Task(
      {required this.title,
      required this.description,
      required this.importance,
      required this.date,
      required this.icon});
}
