import 'package:hive_flutter/adapters.dart';
import 'package:tasks/controllers/database/task.dart';

late Box tasksBox;

void addTask(Task task) {
  tasksBox.add(task);
}

List<Task> getTasks() {
  List<Task> listOfTasks = [];
  for (int i = 0; i < tasksBox.length; i++) {
    listOfTasks.add(tasksBox.get(i));
  }

  return listOfTasks;
}

Task getTask(int id) {
  return tasksBox.get(id);
}

void deleteTask(int id) {
  tasksBox.deleteAt(id);
}
