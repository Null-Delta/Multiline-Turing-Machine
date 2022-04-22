import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/ui/line.dart';
import 'package:provider/provider.dart';
import '../scrollAbleList/scrollable_positioned_list.dart';
import '../styles/app_colors.dart';
import 'line_cell.dart';

class LinesPage extends StatefulWidget {
  LinesPage({Key? key, required this.machine}) : super(key: key);

  final TuringMachine machine;

  late void Function() onScroll;

  @override
  State<LinesPage> createState() => _LinesPageState();
}

class _LinesPageState extends State<LinesPage> {
  late var lines = [
    for (int i = 0; i < widget.machine.model.countOfLines; i++)
      Line(
        machine: widget.machine,
        index: i,
      ),
  ];

  void onScroll() {
    for (var element in lines) {
      element.scrollToCenter();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.onScroll = onScroll;
  }

  @override
  Widget build(BuildContext build) {
    return Expanded(
      child: Container(
        constraints: const BoxConstraints(maxHeight: double.infinity),
        color: AppColors.backgroundDark,
        child: Column(
          children: lines,
        ),
      ),
    );
  }
}
