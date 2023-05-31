import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks/main.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  @override
  Widget build(BuildContext context) {
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
            ListTile(
              onTap: () {},
              title: const Text("Task Name"),
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
            )
          ],
        ));
  }
}
