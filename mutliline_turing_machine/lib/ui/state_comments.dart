import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/ui/machine_inherit.dart';

class StateComments extends StatefulWidget {
  const StateComments({Key? key}) : super(key: key);

  @override
  State<StateComments> createState() => _StateCommentsState();
}

class _StateCommentsState extends State<StateComments> {
  late TuringMachine machine;
  late TextEditingController textController;

  void onEditing() {
    log("${textController.selection.start}");
  }

  bool isFirstLine() {
    return !textController.text
        .substring(0, textController.selection.start)
        .contains('\n');
  }

  @override
  Widget build(BuildContext context) {
    log("rebuild comments");
    machine = MachineInherit.of(context)!.machine;
    textController = TextEditingController(text: machine.model.description);

    var commentsFocus = MachineInherit.of(context)!.commentsFocus;

    textController.addListener(onEditing);
    return Column(
      children: [
        Container(
          color: Theme.of(context).colorScheme.background,
          height: 34,
          child: Center(
            child: Text(
              "Комментарии",
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).cardColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Divider(
          color: Theme.of(context).highlightColor,
          height: 2,
          thickness: 2,
        ),
        Expanded(
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration:
                BoxDecoration(color: Theme.of(context).colorScheme.background),
            child: Focus(
              onKey: (node, event) {
                if (event.isKeyPressed(LogicalKeyboardKey.arrowUp) &&
                    isFirstLine()) {
                  FocusScope.of(context)
                      .focusInDirection(TraversalDirection.up);
                } else if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft) &&
                    textController.selection.start == 0) {
                  FocusScope.of(context)
                      .parent!
                      .focusInDirection(TraversalDirection.left);
                }
                return KeyEventResult.ignored;
              },
              child: TextFormField(
                focusNode: commentsFocus,
                controller: textController,
                onChanged: (newValue) {
                  machine.model.description = newValue;
                },
                maxLines: 10000,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).cardColor,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.only(left: 12, top: 12, bottom: 12),
                  hoverColor: Theme.of(context).colorScheme.background,
                  border: InputBorder.none,
                  fillColor: Theme.of(context).colorScheme.background,
                  isDense: false,
                  //filled: true,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
