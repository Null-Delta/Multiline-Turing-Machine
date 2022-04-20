import 'package:flutter/material.dart';
import '../scrollAbleList/scrollable_positioned_list.dart';
import 'line_cell.dart';

class Line extends StatefulWidget {
  const Line({Key? key}) : super(key: key);

  @override
  State<Line> createState() => _LineState();
}

class _LineState extends State<Line> {
  
  static const double _widthOfCell = 28;
  static const double _widthOfSeparator = 4;

  int cellCount = 2001;
  ItemScrollController control = ItemScrollController();

  late var line =  ScrollablePositionedList.separated(
            itemScrollController: control,
            scrollDirection: Axis.horizontal,
            itemCount: cellCount,
            initialScrollIndex: 0,
            itemBuilder: (context, index) { 
              return Stack(
                children: [
                  const LineCell(),
                  Container (
                    padding: const EdgeInsets.fromLTRB(0, 56, 0, 0),
                    child: SizedBox(
                    width: 28,
                    height: 20,
                    child:  Text(
                      (index-cellCount~/2).toString(),
                       textAlign: TextAlign.center,
                       style: const TextStyle(
                          fontSize: 10, 
                        )
                      )
                    )
                  )
                  
                ],
              );
             },
            separatorBuilder: (context, index) { return const SizedBox( width: _widthOfSeparator); }
            );    
 
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      control.jumpTo(index: cellCount~/2, alignment: 0.5, myIndent: _widthOfCell/2);
      });
  }

  @override
  Widget build(BuildContext build) {

    if (control.isAttached){
        control.jumpTo(index: cellCount~/2, alignment: 0.5, myIndent: _widthOfCell/2);
    }

    return GestureDetector(
      onTap: () {  
      },
      child: Align(alignment: Alignment.center,
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 67,
          child: line
        ),
      ) 
    );;
  }
}
