import 'package:flutter/material.dart';

import '../controllers/database/task.dart';

List<Task> sortTasks(List<Task> tasks) {
  List<Task> listOfTasks = tasks;
  List<Task> withoutDate = [];
  List<Task> includedDate = [];
  for (Task task in listOfTasks) {
    if (task.date != null) {
      int insertPosition = 0;
      if (includedDate.isNotEmpty) {
        for (Task includedTask in includedDate) {
          if (includedTask.date!.compareTo(task.date!) < 0) {
            includedDate.insert(insertPosition, task);
            insertPosition = 0;
            break;
          }
          debugPrint(insertPosition.toString() + " Insert Position");
          insertPosition += 1;
        }
      } else {
        includedDate.add(task);
      }
    } else {
      withoutDate.add(task);
    }
  }
  listOfTasks = includedDate.reversed.toList() + withoutDate;

  return listOfTasks;
}
