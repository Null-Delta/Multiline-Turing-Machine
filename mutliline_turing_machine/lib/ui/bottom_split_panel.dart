import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:mutliline_turing_machine/ui/state_comments.dart';
import 'package:mutliline_turing_machine/ui/turing_machine_table.dart';

class BottomSplitPanel extends StatefulWidget {
  const BottomSplitPanel({Key? key, required this.table}) : super(key: key);

  @override
  State<BottomSplitPanel> createState() => BottomSplitPanelState();
  final TuringMachineTable table;
}

class BottomSplitPanelState extends State<BottomSplitPanel> {
  var needShowComments = true;

  void changeCommentsShow() {
    setState(() {
      needShowComments = !needShowComments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return needShowComments
        ? MultiSplitView(
            antiAliasingWorkaround: false,
            axis: Axis.horizontal,
            minimalSizes: const [322, 138],
            initialWeights: const [0.8, 0.2],
            //minimalWeights: [0.5, 0.1],
            resizable: true,
            // ignore: prefer_const_constructors
            children: [widget.table, StateComments()],
          )
        : widget.table;
  }
}
