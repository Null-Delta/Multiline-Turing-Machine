import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/ui/line.dart';
import 'package:provider/provider.dart';
import '../scrollAbleList/scrollable_positioned_list.dart';
import '../styles/app_colors.dart';
import 'line_cell.dart';

class LinesPage extends StatefulWidget {
  const LinesPage({Key? key, required this.machine}) : super(key: key);

  final TuringMachine machine;

  @override
  State<LinesPage> createState() => _LinesPageState();
}

class _LinesPageState extends State<LinesPage> {
  @override
  Widget build(BuildContext build) {
    return Expanded(
      child: Container(
        constraints: const BoxConstraints(maxHeight: double.infinity),
        color: AppColors.backgroundDark,
        child: Column(
          children: [
            for (int i = 0; i < 1; i++) Line(mahine: widget.machine),
            const Text("|")
          ],
        ),
      ),
    );
  }
}
