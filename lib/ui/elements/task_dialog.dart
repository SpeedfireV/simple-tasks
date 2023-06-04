import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks/controllers/state_management/task_values.dart';
import 'package:tasks/functions/date_time.dart';
import 'package:tasks/main.dart';

import '../../controllers/database/db_functions.dart';
import '../../controllers/database/task.dart';
import '../../functions/category_icon.dart';

class CancelDialog extends ConsumerWidget {
  const CancelDialog(
      {super.key, required this.tasksNotifier, required this.id});
  final int id;
  final TasksNotifier tasksNotifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      icon: const Icon(Icons.delete),
      title: const Text("Delete Task"),
      content: const Text("Are you sure, you want to delete this task?"),
      actions: [
        TextButton(
            onPressed: () {
              router.pop();
            },
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.grey[600]),
            )),
        TextButton(
            onPressed: () {
              deleteTask(id);
              tasksNotifier.addTasks(getTasks());

              router.pop();
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Successfully deleted")));
            },
            child: const Text(
              "Delete task",
              style: TextStyle(color: Colors.red),
            ))
      ],
    );
  }
}

class TaskDialog extends ConsumerWidget {
  const TaskDialog({super.key, required this.task, required this.id});
  final Task task;
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          task.category != 0
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(categoryIcon(task.category), size: 32),
                  ],
                )
              : const SizedBox(),
          const SizedBox(height: 8),
          Text(
            task.title,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          task.description != null
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 12),
                      child: Text(
                        task.description!,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                    const Divider()
                  ],
                )
              : const SizedBox(height: 16),
          task.date != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "${dateType(task.typeOfDate)} ${formatDateTime(date: task.date!, time: task.time)}"),
                      Text("Importance: ${task.importance}",
                          style: task.importance > 3
                              ? const TextStyle(fontWeight: FontWeight.w600)
                              : null)
                    ],
                  ),
                )
              : Text("Importance: ${task.importance}",
                  style: task.importance > 3
                      ? const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 15)
                      : const TextStyle(
                          fontSize: 15,
                        )),
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: () {
              importanceValue = task.importance;
              categoryValue = task.category;
              typeOfDateValue = task.typeOfDate;
              router.pop();
              router.pushNamed("add", queryParameters: {"id": id.toString()});
            },
            label: const Text("Edit"),
            icon: const Icon(Icons.edit),
          )
        ]),
      ),
    );
  }
}
