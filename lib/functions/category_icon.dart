import 'package:flutter/material.dart';

IconData categoryIcon(int number) {
  switch (number) {
    case 0:
      return Icons.radio_button_unchecked;
    case 1:
      return Icons.home_outlined;
    case 2:
      return Icons.local_hospital_outlined;
    case 3:
      return Icons.work_outline;
    case 4:
      return Icons.sports_baseball_outlined;
    default:
      return Icons.radio_button_unchecked;
  }
}
