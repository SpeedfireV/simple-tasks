import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks/controllers/database/db_functions.dart';

import '../database/task.dart';

final importanceProvider = StateProvider.autoDispose((ref) => 3);
final typeOfDateProvider = StateProvider.autoDispose((ref) => 1);
final categoryProvider = StateProvider.autoDispose((ref) => 0);

final currentDatabaseProvider = Provider((ref) => tasksBox);

final currentTasksProvider = StateProvider<List<Task>>((ref) {
  final box = ref.watch(currentDatabaseProvider);
  List<Task> _listOfTasks = [];
  for (Task element in box.values) {
    _listOfTasks.add(element);
  }

  return _listOfTasks;
});
