import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks/controllers/database/db_functions.dart';
import 'package:tasks/controllers/database/task.dart';
import 'package:tasks/controllers/state_management/animations.dart';
import 'package:tasks/controllers/state_management/task_values.dart';
import 'package:tasks/functions/date_time.dart';
import 'package:tasks/main.dart';

import '../functions/category_icon.dart';

class AddTaskPage extends ConsumerStatefulWidget {
  const AddTaskPage({super.key, this.query});
  final String? query;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends ConsumerState<AddTaskPage> {
  late FocusNode focusNodeTitle;
  late FocusNode focusNodeDescription;
  late FocusNode focusNodeDateHour;
  late FocusNode focusNodeCategory;

  DateTime? date;
  DateTime? time;
  int? importance;

  final _formKey = GlobalKey<FormState>();

  final dateHourController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    focusNodeTitle = FocusNode();
    focusNodeCategory = FocusNode();
    focusNodeDescription = FocusNode();
    focusNodeDateHour = FocusNode();

    ref.read(importanceProvider);
    ref.read(typeOfDateProvider);
    ref.read(categoryProvider);
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    focusNodeTitle.dispose();
    focusNodeDescription.dispose();
    focusNodeDateHour.dispose();
    focusNodeCategory.dispose();
    importanceValue = null;
    categoryValue = null;
    typeOfDateValue = null;
  }

  @override
  Widget build(BuildContext context) {
    var currentDate = DateTime.now();
    ref.watch(importanceProvider);
    ref.watch(typeOfDateProvider);
    ref.watch(categoryProvider);
    ref.watch(currentTasksProvider);
    final animationsNotifier = ref.watch(buttonsHeight.notifier);
    final tasksNotifier = ref.watch(currentTasksProvider.notifier);

    if (widget.query != null) {
      Task taskInfo = getTask(int.parse(widget.query!));
      titleController.text = taskInfo.title;
      importance = taskInfo.importance;

      if (taskInfo.description != null) {
        descriptionController.text = taskInfo.description!;
      }

      if (taskInfo.date != null) {
        if (taskInfo.time != null) {
          dateHourController.text =
              formatDateTime(date: taskInfo.date!, time: taskInfo.time!);
          date = taskInfo.date!;
          time = taskInfo.time!;
        } else {
          dateHourController.text = formatDateTime(date: taskInfo.date!);
          date = taskInfo.date!;
        }
      }
    }

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
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: 12, right: 12, top: 16),
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the name';
                      }
                      return null;
                    },
                    onChanged: (value) => _formKey.currentState!.validate(),
                    focusNode: focusNodeTitle,
                    controller: titleController,
                    decoration: InputDecoration(
                        prefixIcon: IconButton(
                          icon: Icon(categoryIcon(
                              ref.read(categoryProvider.notifier).state)),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Consumer(
                                    builder:
                                        (BuildContext context, ref, child) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 16.0),
                                            child: Text(
                                              "Categories",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Flexible(
                                            child: ListView(
                                              shrinkWrap: true,
                                              children: [
                                                ListTile(
                                                  title:
                                                      const Text("No Category"),
                                                  leading: const Icon(Icons
                                                      .radio_button_unchecked),
                                                  onTap: () {
                                                    // Set Icon To No Category
                                                    ref
                                                        .read(categoryProvider
                                                            .notifier)
                                                        .state = 0;
                                                    router.pop();
                                                  },
                                                ),
                                                ListTile(
                                                  title: const Text("Home"),
                                                  leading: const Icon(
                                                      Icons.home_outlined),
                                                  onTap: () {
                                                    // Set Icon To Home
                                                    ref
                                                        .read(categoryProvider
                                                            .notifier)
                                                        .state = 1;
                                                    router.pop();
                                                  },
                                                ),
                                                ListTile(
                                                  title: const Text("Health"),
                                                  leading: const Icon(Icons
                                                      .local_hospital_outlined),
                                                  onTap: () {
                                                    // Set Icon To Home
                                                    ref
                                                        .read(categoryProvider
                                                            .notifier)
                                                        .state = 2;
                                                    router.pop();
                                                  },
                                                ),
                                                ListTile(
                                                  title: const Text("Work"),
                                                  leading: const Icon(
                                                      Icons.work_outline),
                                                  onTap: () {
                                                    // Set Icon To Home
                                                    ref
                                                        .read(categoryProvider
                                                            .notifier)
                                                        .state = 3;
                                                    router.pop();
                                                  },
                                                ),
                                                ListTile(
                                                  title: const Text("Hobby"),
                                                  leading: const Icon(Icons
                                                      .sports_baseball_outlined),
                                                  onTap: () {
                                                    // Set Icon To Home
                                                    ref
                                                        .read(categoryProvider
                                                            .notifier)
                                                        .state = 4;
                                                    router.pop();
                                                  },
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  );
                                });
                          },
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        border: const OutlineInputBorder(),
                        hintText: "Name of a task*"),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: descriptionController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.description_outlined),
                        hintText: "Description",
                        border: OutlineInputBorder()),
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
                              ),
                              DropdownMenuItem(
                                value: 3,
                                child: Text("At"),
                              )
                            ],
                            onChanged: (value) {
                              ref.read(typeOfDateProvider.notifier).state =
                                  value!;
                            }),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          focusNode: focusNodeDateHour,
                          controller: dateHourController,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.event),
                              hintText: "Date & Hour",
                              border: OutlineInputBorder()),
                          readOnly: true,
                          onTap: () async {
                            final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: currentDate,
                                firstDate: currentDate,
                                lastDate: DateTime(2100));
                            final TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedDate != null) {
                              date = pickedDate;

                              // Set The Date
                              if (pickedTime != null) {
                                time = DateTime(0, 0, 0, pickedTime.hour,
                                    pickedTime.minute);
                                dateHourController.text = formatDateTime(
                                    date: pickedDate, time: time);
                              } else {
                                dateHourController.text =
                                    formatDateTime(date: pickedDate);
                              }
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
                      GestureDetector(
                        onTap: () =>
                            ref.read(importanceProvider.notifier).state = 1,
                        child: Column(
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
                      ),
                      GestureDetector(
                        onTap: () =>
                            ref.read(importanceProvider.notifier).state = 2,
                        child: Column(
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
                      ),
                      GestureDetector(
                        onTap: () =>
                            ref.read(importanceProvider.notifier).state = 3,
                        child: Column(
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
                      ),
                      GestureDetector(
                        onTap: () =>
                            ref.read(importanceProvider.notifier).state = 4,
                        child: Column(
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
                      ),
                      GestureDetector(
                        onTap: () =>
                            ref.read(importanceProvider.notifier).state = 5,
                        child: Column(
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
                  const SizedBox(height: 90),
                ]),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0, top: 16),
                child: AnimatedContainer(
                  duration: Duration.zero,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Task currentTask = Task(
                              title: titleController.text,
                              description: descriptionController.text.isNotEmpty
                                  ? descriptionController.text
                                  : null,
                              importance:
                                  ref.read(importanceProvider.notifier).state,
                              typeOfDate:
                                  ref.read(typeOfDateProvider.notifier).state,
                              date: date,
                              time: time,
                              category:
                                  ref.read(categoryProvider.notifier).state);

                          if (widget.query != null) {
                            editTask(int.parse(widget.query!), currentTask);
                          } else {
                            addTask(currentTask);
                          }
                          tasksNotifier.addTasks(getTasks());

                          router.pop();

                          ScaffoldMessenger.of(context).hideCurrentSnackBar();

                          animationsNotifier.state = 40;
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
                                  duration: const Duration(milliseconds: 1500),
                                  content: Center(
                                      child: Text(widget.query != null
                                          ? "Successfully edited"
                                          : "Successfully added"))))
                              .closed
                              .then((value) => animationsNotifier.state = 0);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(180, 60), elevation: 3),
                      child: const Text(
                        "Submit",
                        style: TextStyle(fontSize: 16),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
