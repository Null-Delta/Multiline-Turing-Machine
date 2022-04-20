import 'dart:developer';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter/material.dart';
import 'line_cell.dart';

class Line extends StatefulWidget {
  const Line({Key? key}) : super(key: key);

  @override
  State<Line> createState() => _LineState();
}

class _LineState extends State<Line> {
  ItemScrollController control = ItemScrollController();
  late var line =  ScrollablePositionedList.separated(
            itemScrollController: control,
            scrollDirection: Axis.horizontal,
            itemCount: 101,
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            initialScrollIndex: 0,
            itemBuilder: (context, index) { return Stack(
              children: [
                const LineCell(),
                Text((index-50).toString())
              ],
            );
             },
            separatorBuilder: (context, index) { return const SizedBox( width: 4); });    
 
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      control.jumpTo(index: 101~/2 - MediaQuery.of(context).size.width~/64);
      });
  }
 
  @override
  Widget build(BuildContext build) {
    if (control.isAttached){
        control.jumpTo(index: 101~/2 - MediaQuery.of(context).size.width~/64);
    }
    
    var jj = GestureDetector(
      onTap: () {  
      },
      onSecondaryTap: () {
      },
      child: Align(alignment: Alignment.center,
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: line
        ),
      ) 
    );
    
    return jj;
  }
}
