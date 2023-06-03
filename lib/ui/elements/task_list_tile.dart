import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks/controllers/database/db_functions.dart';
import 'package:tasks/controllers/database/task.dart';
import 'package:tasks/controllers/state_management/task_values.dart';
import 'package:tasks/functions/category_icon.dart';
import 'package:tasks/functions/date_time.dart';
import 'package:tasks/ui/elements/task_dialog.dart';

class ListTileTask extends ConsumerStatefulWidget {
  const ListTileTask({super.key, required this.task, required this.id});

  final Task task;
  final int id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListTileTaskState();
}

class _ListTileTaskState extends ConsumerState<ListTileTask> {
  @override
  Widget build(BuildContext context) {
    final tasksNotfier = ref.watch(currentTasksProvider.notifier);
    final tasks = ref.watch(currentTasksProvider);

    return ListTile(
      subtitle: Text(widget.task.date != null
          ? formatDateTime(date: widget.task.date!, time: widget.task.time)
          : ""),
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return TaskDialog(task: widget.task);
            });
      },
      title: Text(widget.task.title),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.inversePrimary),
            child: Center(
              child: Text(
                widget.task.importance.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          widget.task.category != 0
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 8),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.inversePrimary),
                      child: Icon(
                        categoryIcon(widget.task.category),
                        color: Colors.black,
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.cancel),
            color: Colors.red,
            onPressed: () {
              deleteTask(widget.id);
              tasksNotfier.addTasks(getTasks());
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.check,
            ),
            color: Colors.green,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
