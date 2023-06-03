import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks/controllers/database/db_functions.dart';
import 'package:tasks/controllers/state_management/task_values.dart';
import 'package:tasks/main.dart';
import 'package:tasks/ui/elements/task_list_tile.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  @override
  void initState() {
    super.initState();

    ref.read(currentTasksProvider);
  }

  @override
  Widget build(BuildContext context) {
    final tasksNotifier = ref.watch(currentTasksProvider.notifier);
    final tasks = ref.watch(currentTasksProvider);

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            router.pushNamed("add");
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text("Current Tasks"),
          centerTitle: true,
          elevation: 3,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: ListView(
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tasksBox.length,
                itemBuilder: (context, index) {
                  return ListTileTask(task: tasks[index], id: index);
                }),
            const SizedBox(height: 70)
          ],
        ));
  }
}
