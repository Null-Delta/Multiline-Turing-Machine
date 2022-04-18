import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/styles/app_button.dart';
import 'package:mutliline_turing_machine/styles/app_images.dart';
import '../styles/app_colors.dart';

class BottomPanel extends StatefulWidget {
  const BottomPanel({Key? key}) : super(key: key);

  @override
  State<BottomPanel> createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel> {
  static const double iconSize = 28;
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
                      image: AppImages.addState,
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
                  child: const Image(
                    image: AppImages.deleteState,
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
