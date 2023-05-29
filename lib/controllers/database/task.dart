import 'package:flutter/material.dart';

class Task {
  final String title;
  final String description;
  final int importance;
  final DateTime date;
  final IconData? icon;
  final bool important;

  Task(
      {required this.important,
      required this.description,
      required this.importance,
      required this.date,
      this.icon,
      required this.title});
}

class TaskAdapter extends TaskAdapter<Task> {}
