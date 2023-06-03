import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks/functions/date_time.dart';
import 'package:tasks/main.dart';

import '../../controllers/database/task.dart';
import '../../functions/category_icon.dart';

class TaskDialog extends ConsumerWidget {
  const TaskDialog({super.key, required this.task});
  final Task task;

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
              : const SizedBox(),
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: () {
              router.pop();
            },
            label: const Text("Edit"),
            icon: const Icon(Icons.edit),
          )
        ]),
      ),
    );
  }
}
