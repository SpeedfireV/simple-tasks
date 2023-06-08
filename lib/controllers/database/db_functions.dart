import 'package:hive_flutter/adapters.dart';
import 'package:tasks/controllers/database/task.dart';

import '../../functions/tasks_sorting.dart';

late Box tasksBox;

void addTask(Task task) {
  tasksBox.add(task);
}

void editTask(int id, Task task) {
  tasksBox.putAt(id, task);
}

List<Task> getTasks() {
  List<Task> listOfTasks = [];
  for (int i = 0; i < tasksBox.length; i++) {
    listOfTasks.add(tasksBox.getAt(i));
  }

  return sortTasks(listOfTasks);
}

Task getTask(int id) {
  return tasksBox.getAt(id);
}

void deleteTask(int id) {
  tasksBox.deleteAt(id);
}
