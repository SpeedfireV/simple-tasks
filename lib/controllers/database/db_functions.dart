import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tasks/controllers/database/task.dart';

late Box tasksBox;

void addTask(Task task) {
  debugPrint("What happens!?!?!");

  tasksBox.add(task);
}

List<Task> getTasks() {
  List<Task> listOfTasks = [];
  for (int i = 0; i < tasksBox.length; i++) {
    listOfTasks.add(tasksBox.get(i));
  }
  debugPrint("Getting tasks $listOfTasks");
  debugPrint(tasksBox.length.toString() + "Length");

  return listOfTasks;
}

Task getTask(int id) {
  return tasksBox.get(id);
}
