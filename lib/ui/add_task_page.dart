import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks/main.dart';

class AddTaskPage extends ConsumerStatefulWidget {
  const AddTaskPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends ConsumerState<AddTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            router.pop();
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(shrinkWrap: true, children: [
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Name of a task*"),
              ),
              SizedBox(height: 8),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                    hintText: "Description", border: OutlineInputBorder()),
              ),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                    hintText: "Date", border: OutlineInputBorder()),
              ),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                    hintText: "Date", border: OutlineInputBorder()),
              ),
              SizedBox(height: 70),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: ElevatedButton(
                onPressed: () {
                  router.pop();
                },
                child: Text("Submit")),
          ),
        ],
      ),
    );
  }
}
