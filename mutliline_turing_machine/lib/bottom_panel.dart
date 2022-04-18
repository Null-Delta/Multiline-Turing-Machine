import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:mutliline_turing_machine/styles/app_button.dart';
import 'package:mutliline_turing_machine/styles/app_images.dart';
import 'styles/app_colors.dart';
import 'package:mutliline_turing_machine/table/lib/pluto_grid.dart';
import 'dart:developer' as developer;

class BottomPanel extends StatefulWidget {
  const BottomPanel({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<BottomPanel> createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel> {
  static const double iconSize = 16;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(
            left: 6,
            right: 6,
          ),
          height: 40,
          color: AppColors.background,
          child: Row(
            children: [
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "Добавить состояние",
                child: ElevatedButton(
                  onPressed: () {},
                  child: const SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(
                      image: AppImages.stateAdd,
                    ),
                  ),
                  style: appButtonStyle,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "Удалить состояние",
                child: ElevatedButton(
                  onPressed: () {},
                  child: const SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(
                      image: AppImages.stateDelete,
                    ),
                  ),
                  style: appButtonStyle,
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 2,
          thickness: 2,
          color: AppColors.highlight,
        ),
      ],
    );
  }
}
