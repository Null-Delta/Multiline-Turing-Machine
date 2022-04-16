import 'package:flutter/material.dart';

class PlutoShadowLine extends StatelessWidget {
  final Axis? axis;
  final bool? reverse;
  final Color? color;
  final bool? shadow;

  const PlutoShadowLine({
    this.axis,
    this.reverse,
    this.color,
    this.shadow,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: axis == Axis.vertical ? 2 : 0,
      height: axis == Axis.horizontal ? 2 : 0,
      decoration: BoxDecoration(
        color: color ?? Colors.black,
        boxShadow: shadow == true
            ? [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: reverse == true
                      ? const Offset(-3, -3)
                      : const Offset(3, 3), // changes position of shadow
                ),
              ]
            : [],
      ),
    );
  }
}
