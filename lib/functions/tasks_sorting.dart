import '../controllers/database/task.dart';

List<Task> sortTasks(List<Task> tasks) {
  List<Task> listOfTasks = tasks;
  List<Task> withoutDate = [];
  List<Task> includedDate = [];
  for (Task task in listOfTasks) {
    if (task.date != null) {
      int insertPosition = 0;
      if (includedDate.isNotEmpty) {
        for (Task includedTask in includedDate) {
          if (includedTask.date!.compareTo(task.date!) < 0) {
            includedDate.insert(insertPosition, task);
            insertPosition = 0;
            break;
          }
          insertPosition += 1;
        }
      } else {
        includedDate.add(task);
      }
    } else {
      withoutDate.add(task);
    }
  }
  listOfTasks = includedDate.reversed.toList() + withoutDate;

  return listOfTasks;
}

bool activeTask(Task task) {
  if (task.date == null) {
    return false;
  }
  DateTime date = task.date!;
  DateTime? time = task.time;
  late DateTime dateHour;
  DateTime now = DateTime.now();

  if (time != null) {
    dateHour =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
  } else {
    dateHour = DateTime(date.year, date.month, date.day);
  }

  if (dateHour.compareTo(now) > 0) {
    return false;
  } else {
    return true;
  }
}
