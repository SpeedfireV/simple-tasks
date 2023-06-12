import 'package:hive_flutter/adapters.dart';
import 'package:tasks/controllers/database/task.dart';

late Box tasksBox;
late Box archiveBox;

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

  return listOfTasks;
}

Task getTask(int id) {
  return tasksBox.getAt(id);
}

void deleteTask(int id) {
  tasksBox.deleteAt(id);
}

void addToArchive(Task task) {
  archiveBox.add(task);
}

List<Task> getArchives() {
  List<Task> listOfArchives = [];
  for (int i = 0; i < archiveBox.length; i++) {
    listOfArchives.add(archiveBox.getAt(i));
  }

  return listOfArchives;
}
