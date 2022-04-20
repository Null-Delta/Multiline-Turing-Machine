import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/styles/app_colors.dart';

class StatesList extends StatefulWidget {
  const StatesList(
      {Key? key, required this.machine, required this.onStateSelect})
      : super(key: key);

  final TuringMachine machine;
  final void Function(int index) onStateSelect;

  @override
  State<StatesList> createState() => _StatesListState();
}

class _StatesListState extends State<StatesList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 84,
      color: AppColors.background,
      child: Column(
        children: [
          SizedBox(
            height: 34,
            child: Center(
              child: Text(
                "Состояния",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                ),
              ),
            ),
          ),
          Divider(
            height: 2,
            thickness: 2,
            color: AppColors.highlight,
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(6),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => widget.onStateSelect(index),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: index == widget.machine.currentStateIndex
                          ? AppColors.accent
                          : AppColors.background,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(6),
                      ),
                    ),
                    height: 36,
                    child: Center(
                      child: Text(
                        "Q${index + 1}",
                        style: TextStyle(
                            color: index == widget.machine.currentStateIndex
                                ? AppColors.background
                                : AppColors.text,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 6);
              },
              itemCount: widget.machine.model.countOfStates,
            ),
          ),
        ],
      ),
    );
  }
}
