import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks/controllers/state_management/archive.dart';
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
    ref.read(archiveActiveProvider);
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(currentTasksProvider);
    final archiveActive = ref.watch(archiveActiveProvider);
    final archiveNotifier = ref.watch(archiveActiveProvider.notifier);
    final archives = ref.watch(currentArchivesProvider);

    return Scaffold(
        appBar: AppBar(
          title: archiveActive
              ? const Text("Archives")
              : const Text("Current Tasks"),
          centerTitle: true,
          elevation: 3,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                archiveActive
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: archives.length,
                        itemBuilder: (context, index) {
                          return DoneListTile(
                              task: archives[archives.length - index - 1],
                              id: index);
                        })
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          return ListTileTask(task: tasks[index], id: index);
                        }),
                const SizedBox(height: 70)
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FloatingActionButton(
                      heroTag: "archive",
                      onPressed: () {
                        archiveNotifier.state = !archiveActive;
                      },
                      child: Icon(archiveNotifier.state
                          ? Icons.inbox_outlined
                          : Icons.inventory_2_outlined),
                    ),
                    FloatingActionButton(
                      heroTag: "newTask",
                      onPressed: () {
                        archiveNotifier.state = false;
                        router.pushNamed("add");
                      },
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
