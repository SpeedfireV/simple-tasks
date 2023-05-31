import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks/controllers/state_management/add_task_values.dart';
import 'package:tasks/main.dart';

class AddTaskPage extends ConsumerStatefulWidget {
  const AddTaskPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends ConsumerState<AddTaskPage> {
  @override
  void initState() {
    super.initState();

    ref.read(importanceProvider);
    ref.read(typeOfDateProvider);
    ref.read(titleProvider);
  }

  @override
  Widget build(BuildContext context) {
    var currentDate = DateTime.now();
    ref.watch(importanceProvider);
    ref.watch(typeOfDateProvider);
    ref.watch(titleProvider);

    final titleController = TextEditingController();
    FocusNode node = FocusNode();
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Add Task"),
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
            child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: 12, right: 12, top: 16),
                children: [
                  TextField(
                    focusNode: node,
                    controller: titleController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Name of a task*"),
                    onChanged: (value) {
                      ref.read(titleProvider.notifier).state = value;
                      titleController.text = value;
                    },
                  ),
                  const SizedBox(height: 12),
                  const TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                        hintText: "Description", border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: DropdownButtonFormField(
                            value: ref.read(typeOfDateProvider.notifier).state,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder()),
                            items: const [
                              DropdownMenuItem(
                                value: 1,
                                child: Text("Until"),
                              ),
                              DropdownMenuItem(
                                value: 2,
                                child: Text("Since"),
                              )
                            ],
                            onChanged: (value) {
                              ref.read(typeOfDateProvider.notifier).state =
                                  value!;
                            }),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                              hintText: "Date & Hour",
                              border: OutlineInputBorder()),
                          onTap: () async {
                            final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: currentDate,
                                firstDate: currentDate,
                                lastDate: DateTime(2100));
                            if (pickedDate != null) {
                              // Set The Date
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Importance",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Radio(
                              value: 1,
                              groupValue:
                                  ref.read(importanceProvider.notifier).state,
                              onChanged: (value) {
                                ref.read(importanceProvider.notifier).state =
                                    value!;
                              }),
                          const Text("1")
                        ],
                      ),
                      Column(
                        children: [
                          Radio(
                              value: 2,
                              groupValue:
                                  ref.read(importanceProvider.notifier).state,
                              onChanged: (value) {
                                ref.read(importanceProvider.notifier).state =
                                    value!;
                              }),
                          const Text("2")
                        ],
                      ),
                      Column(
                        children: [
                          Radio(
                              value: 3,
                              groupValue:
                                  ref.read(importanceProvider.notifier).state,
                              onChanged: (value) {
                                ref.read(importanceProvider.notifier).state =
                                    value!;
                              }),
                          const Text("3")
                        ],
                      ),
                      Column(
                        children: [
                          Radio(
                              value: 4,
                              groupValue:
                                  ref.read(importanceProvider.notifier).state,
                              onChanged: (value) {
                                ref.read(importanceProvider.notifier).state =
                                    value!;
                              }),
                          const Text("4")
                        ],
                      ),
                      Column(
                        children: [
                          Radio(
                              value: 5,
                              groupValue:
                                  ref.read(importanceProvider.notifier).state,
                              onChanged: (value) {
                                ref.read(importanceProvider.notifier).state =
                                    value!;
                              }),
                          const Text("5")
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Not Important",
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                      Text("Very Important",
                          style: TextStyle(fontWeight: FontWeight.w300))
                    ],
                  ),
                  const SizedBox(height: 20),
                ]),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0, top: 16),
            child: AnimatedContainer(
              duration: Duration.zero,
              child: ElevatedButton(
                  onPressed: () {
                    debugPrint(ref.read(titleProvider.notifier).state);
                    router.pop();
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(180, 60), elevation: 3),
                  child: const Text(
                    "Submit",
                    style: TextStyle(fontSize: 16),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
