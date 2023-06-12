import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks/controllers/database/task.dart';
import 'package:tasks/controllers/state_management/animations.dart';
import 'package:tasks/controllers/state_management/archive.dart';
import 'package:tasks/controllers/state_management/task_values.dart';
import 'package:tasks/functions/category_icon.dart';
import 'package:tasks/functions/date_time.dart';
import 'package:tasks/functions/tasks_sorting.dart';
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
    final archiveNotifier = ref.watch(currentArchivesProvider.notifier);
    final animationsNotfier = ref.watch(buttonsHeight.notifier);

    return ListTile(
      tileColor: activeTask(widget.task) ? Colors.red[100] : Colors.white,
      subtitle: widget.task.date != null
          ? Text(
              "${dateType(widget.task.typeOfDate)} ${formatDateTime(date: widget.task.date!, time: widget.task.time)}")
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
              addToArchive(widget.task..doneTime = DateTime.now());

              archiveNotifier.addArchives(getArchives());
              tasksNotifier.addTasks(getTasks());

              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              animationsNotfier.state = 48;
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(
                      duration: Duration(milliseconds: 1500),
                      content: Center(child: Text("Congratulations!"))))
                  .closed
                  .then((value) {
                animationsNotfier.state = 0;
              });
            },
          ),
        ],
      ),
    );
  }
}

class DoneListTile extends ConsumerWidget {
  const DoneListTile({super.key, required this.task, required this.id});
  final Task task;
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      tileColor: activeTask(task) ? Colors.red[100] : Colors.white,
      subtitle: task.date != null
          ? Text(
              "Done: ${formatDateTime(date: task.doneTime!, time: task.doneTime)}")
          : null,
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return TaskDialog(task: task, id: id, editDisabled: true);
            });
      },
      title: Text(task.title),
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
                task.importance.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight:
                      task.importance > 3 ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          ),
          task.category != 0
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
                        categoryIcon(task.category),
                        color: Colors.black,
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
