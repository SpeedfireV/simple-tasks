import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  if (kDebugMode) {
    print('Debug mode enabled');
  }

  Hive.registerAdapter(TaskAdapter());

  tasksBox = await Hive.openBox<Task>("tasks");
  archiveBox = await Hive.openBox<Task>("archive");

  runApp(const ProviderScope(child: MyApp()));
}

final router = GoRouter(routes: [
  GoRoute(
      path: "/", name: "main", builder: (context, state) => const MainPage()),
  GoRoute(
      path: "/add_task",
      name: "add",
      builder: (context, state) {
        final query = state.queryParameters['id'];
        return AddTaskPage(query: query);
      })
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return SafeArea(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
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
