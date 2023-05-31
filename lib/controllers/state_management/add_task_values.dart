import 'package:flutter_riverpod/flutter_riverpod.dart';

final importanceProvider = StateProvider.autoDispose((ref) => 3);
final typeOfDateProvider = StateProvider.autoDispose((ref) => 1);

final titleProvider = StateProvider.autoDispose((ref) => "");
