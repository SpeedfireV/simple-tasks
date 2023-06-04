import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks/controllers/database/db_functions.dart';

import '../database/task.dart';

int? importanceValue;
int? typeOfDateValue;
int? categoryValue;

final importanceProvider = StateProvider.autoDispose(
    (ref) => importanceValue != null ? importanceValue : 3);
final typeOfDateProvider = StateProvider.autoDispose(
    (ref) => typeOfDateValue != null ? typeOfDateValue : 1);
final categoryProvider = StateProvider.autoDispose(
    (ref) => categoryValue != null ? categoryValue : 0);

final currentDatabaseProvider = Provider((ref) => getTasks());

final currentTasksProvider =
    StateNotifierProvider<TasksNotifier, List<Task>>((ref) {
  final box = ref.watch(currentDatabaseProvider);
  List<Task> listOfTasks = [];
  for (Task element in box) {
    listOfTasks.add(element);
  }

  return TasksNotifier(listOfTasks);
});

class TasksNotifier extends StateNotifier<List<Task>> {
  TasksNotifier(List<Task> initialTasks) : super(initialTasks);

  void addTasks(List<Task> task) {
    state = task;
  }
}
