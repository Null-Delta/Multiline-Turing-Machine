import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/styles/app_colors.dart';
import 'package:mutliline_turing_machine/ui/machine_inherit.dart';

class StateComments extends StatefulWidget {
  const StateComments({Key? key}) : super(key: key);

  @override
  State<StateComments> createState() => _StateCommentsState();
}

class _StateCommentsState extends State<StateComments> {
  late TuringMachine machine;
  late TextEditingController textController =
      TextEditingController(text: machine.model.description);

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
    machine = MachineInherit.of(context)!.machine;
    var commentsFocus = MachineInherit.of(context)!.commentsFocus;

    textController.addListener(onEditing);
    return Column(
      children: [
        Container(
          color: AppColors.background,
          height: 34,
          child: Center(
            child: Text(
              "Комментарии",
              style: TextStyle(
                fontSize: 12,
                color: AppColors.text,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Divider(
          color: AppColors.highlight,
          height: 2,
          thickness: 2,
        ),
        Expanded(
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(color: AppColors.background),
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
                  fontSize: 14,
                  color: AppColors.text,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.only(left: 12, top: 12, bottom: 12),
                    hoverColor: AppColors.background,
                    border: InputBorder.none,
                    fillColor: AppColors.background,
                    isDense: false,
                    filled: true),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
