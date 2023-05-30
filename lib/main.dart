import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tasks/ui/add_task_page.dart';
import 'package:tasks/ui/main_page.dart';

import 'controllers/database/task.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Hive.initFlutter();

  Hive.registerAdapter(TaskAdapter());

  var tasksBox = Hive.openBox<Task>("tasks");

  runApp(ProviderScope(child: const MyApp()));
}

final router = GoRouter(routes: [
  GoRoute(path: "/", name: "main", builder: (context, state) => MainPage()),
  GoRoute(
      path: "/add_task",
      name: "add",
      builder: (context, state) => AddTaskPage())
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
