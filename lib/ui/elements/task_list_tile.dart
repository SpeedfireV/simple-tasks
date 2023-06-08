import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks/controllers/database/task.dart';
import 'package:tasks/controllers/state_management/task_values.dart';
import 'package:tasks/functions/category_icon.dart';
import 'package:tasks/functions/date_time.dart';
import 'package:tasks/ui/elements/task_dialog.dart';

import '../../controllers/database/db_functions.dart';

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
    final tasksNotifier = ref.watch(currentTasksProvider.notifier);

    return ListTile(
      subtitle: widget.task.date != null
          ? Text(
              formatDateTime(date: widget.task.date!, time: widget.task.time))
          : null,
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return TaskDialog(task: widget.task, id: widget.id);
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
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: widget.task.importance > 3
                      ? FontWeight.w600
                      : FontWeight.w400,
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
            icon: const Icon(Icons.delete),
            color: Colors.red,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => CancelDialog(
                        tasksNotifier: tasksNotifier,
                        id: widget.id,
                      ));
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.check,
            ),
            color: Colors.green,
            onPressed: () {
              deleteTask(widget.id);
              tasksNotifier.addTasks(getTasks());

              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(milliseconds: 1500),
                  content: Center(child: Text("Congratulations!"))));
            },
          ),
        ],
      ),
    );
  }
}
