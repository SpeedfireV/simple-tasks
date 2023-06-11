import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/db_functions.dart';
import '../database/task.dart';

final archiveActiveProvider = StateProvider((ref) => false);

final currentDatabaseArchivesProvider = Provider((ref) => getArchives());

final currentArchivesProvider =
    StateNotifierProvider<ArchivesNotifier, List<Task>>((ref) {
  final box = ref.watch(currentDatabaseArchivesProvider);
  List<Task> listOfArchives = [];
  for (Task element in box) {
    listOfArchives.add(element);
  }

  return ArchivesNotifier(listOfArchives);
});

class ArchivesNotifier extends StateNotifier<List<Task>> {
  ArchivesNotifier(List<Task> initialArchives) : super(initialArchives);

  void addArchives(List<Task> archives) {
    state = archives;
  }
}
