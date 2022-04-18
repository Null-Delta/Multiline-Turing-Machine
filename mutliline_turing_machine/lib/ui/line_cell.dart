import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:mutliline_turing_machine/ui/state_comments.dart';
import '../styles/app_colors.dart';
import 'package:mutliline_turing_machine/table/lib/pluto_grid.dart';
import '../styles/table_configuration.dart';
import 'dart:developer' as developer;

class LineCell extends StatefulWidget {
  const LineCell({Key? key}) : super(key: key);

  @override
  State<LineCell> createState() => _LineCellState();
}

class _LineCellState extends State<LineCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(width: 2),
      ),
    );
  }
}
