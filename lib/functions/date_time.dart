import 'package:flutter/material.dart';

String dateType(int number) {
  switch (number) {
    case 1:
      return "Until";
    case 2:
      return "Since";
    case 3:
      return "At";
    default:
      return "Until";
  }
}

String formatDateTime({required DateTime date, DateTime? time}) {
  DateTime currentDateAndTime = DateTime.now();
  debugPrint(time.toString());

  String text = "";
  String timeString = "";
  // Formating Time
  if (time != null) {
    if (time.hour < 10) {
      timeString += " | 0${time.hour}:";
    } else {
      timeString += " | ${time.hour.toString()}:";
    }

    if (time.minute < 10) {
      timeString += "0${time.minute}";
    } else {
      timeString += time.minute.toString();
    }
  }

  late String dayString;
  late String monthString;

  if (date.day < 10) {
    dayString = "0${date.day}";
  } else {
    dayString = date.day.toString();
  }

  if (date.month < 10) {
    monthString = "0${date.month}";
  } else {
    monthString = date.month.toString();
  }

  // Formating Date
  if (currentDateAndTime.year == date.year &&
      currentDateAndTime.month == date.month) {
    if (date.day == currentDateAndTime.day) {
      text += "Today";
    } else if (date.day - 1 == currentDateAndTime.day) {
      text += "Tommorow";
    } else {
      text += "$dayString.$monthString.${date.year}";
    }
  } else {
    text += "$dayString.$monthString.${date.year}";
  }

  text += timeString;

  return text;
}
