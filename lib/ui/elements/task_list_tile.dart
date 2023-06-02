import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks/controllers/database/task.dart';
import 'package:tasks/functions/category_icon.dart';
import 'package:tasks/functions/date_time.dart';

class ListTileTask extends ConsumerStatefulWidget {
  const ListTileTask({super.key, required this.task});

  final Task task;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListTileTaskState();
}

class _ListTileTaskState extends ConsumerState<ListTileTask> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitle: Text(widget.task.date != null
          ? formatDateTime(
              widget.task.date!,
              TimeOfDay(
                  hour: widget.task.date!.hour,
                  minute: widget.task.date!.minute))
          : ""),
      onTap: () {},
      title: Text(widget.task.title),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.inversePrimary),
            child: Center(
              child: Text(
                widget.task.importance.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          widget.task.category != null
              ? Row(
                  children: [
                    SizedBox(width: 8),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.inversePrimary),
                      child: Icon(
                        widget.task.category != null
                            ? categoryIcon(widget.task.category!)
                            : null,
                        color: Colors.black,
                      ),
                    ),
                  ],
                )
              : SizedBox(),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.cancel),
            color: Colors.red,
            onPressed: () {},
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
