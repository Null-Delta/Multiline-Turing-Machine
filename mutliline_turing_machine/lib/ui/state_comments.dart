import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/styles/app_colors.dart';

class StateComments extends StatefulWidget {
  const StateComments({Key? key, required this.machine}) : super(key: key);

  final TuringMachine machine;

  @override
  State<StateComments> createState() => _StateCommentsState();
}

class _StateCommentsState extends State<StateComments> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
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
            child: TextFormField(
              onChanged: (newValue) {
                widget.machine.model.description = newValue;
              },
              maxLines: 10000,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.text,
                fontWeight: FontWeight.w500,
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
      ],
    );
  }
}
