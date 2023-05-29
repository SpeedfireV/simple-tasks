import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks/controllers/state_management/floating_action_button_state.dart';

class ExpandableFloatingActionButton extends ConsumerStatefulWidget {
  const ExpandableFloatingActionButton({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ExpandableFloatingActionButtonState();
}

class _ExpandableFloatingActionButtonState
    extends ConsumerState<ExpandableFloatingActionButton> {
  @override
  void initState() {
    super.initState();
    ref.read(isOpenedProvider);
  }

  void toggleState(bool newValue) {
    ref.read(isOpenedProvider.notifier).state = newValue;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      FloatingActionButton(
        onPressed: () {},
        heroTag: "1",
      ),
      FloatingActionButton(
        onPressed: () {},
        heroTag: "2",
      )
    ]);
  }
}
