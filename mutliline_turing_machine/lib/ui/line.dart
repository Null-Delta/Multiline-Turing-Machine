import 'package:flutter/material.dart';
import 'line_cell.dart';
import 'scrollable_positioned_list.dart';

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
            initialScrollIndex: 0,
            itemBuilder: (context, index) { 
              return Stack(
                children: [
                  const LineCell(),
                  Text((index-50).toString())
                ],
              );
             },
            separatorBuilder: (context, index) { return const SizedBox( width: 4); }
            );    
 
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      control.jumpTo(index: 101~/2, alignment: 0.5, myIndent: 14);
      });
  }

  @override
  Widget build(BuildContext build) {

    if (control.isAttached){
        control.jumpTo(index: 101~/2, alignment: 0.5, myIndent: 14);
    }

    return GestureDetector(
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
    );;
  }
}
