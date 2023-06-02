import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasks/ui/main_page.dart';

import 'controllers/database/db_functions.dart';
import 'controllers/database/task.dart';
import 'ui/add_task_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter().then((value) => debugPrint("Initialized"));

  Hive.registerAdapter(TaskAdapter());

  tasksBox = await Hive.openBox<Task>("tasks");

  runApp(const ProviderScope(child: MyApp()));
}

final router = GoRouter(routes: [
  GoRoute(
      path: "/", name: "main", builder: (context, state) => const MainPage()),
  GoRoute(
      path: "/add_task",
      name: "add",
      builder: (context, state) => const AddTaskPage())
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }
}
