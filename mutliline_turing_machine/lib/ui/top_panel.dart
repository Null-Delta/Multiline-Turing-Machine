import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/styles/app_button.dart';
import 'package:mutliline_turing_machine/styles/app_images.dart';
import 'package:mutliline_turing_machine/ui/line_cell.dart';
import '../styles/app_colors.dart';
import 'line.dart';

class TopPanel extends StatefulWidget {
  const TopPanel({Key? key, required this.machine}) : super(key: key);

  final TuringMachine machine;
  @override
  State<TopPanel> createState() => _TopPanelState();
}

class _TopPanelState extends State<TopPanel> {
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
                message: "Файл",
                child: ElevatedButton(
                  onPressed: () {},
                  child: const SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(
                      image: AppImages.file,
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
                message: "Настройки",
                child: ElevatedButton(
                  onPressed: () {},
                  child: const SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(
                      image: AppImages.settings,
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
                message: "О приложении",
                child: ElevatedButton(
                  onPressed: () {},
                  child: const SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(
                      image: AppImages.happy,
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
                message: "Справка",
                child: ElevatedButton(
                  onPressed: () {},
                  child: const SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(
                      image: AppImages.help,
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
