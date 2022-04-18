import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:mutliline_turing_machine/styles/app_button.dart';
import 'package:mutliline_turing_machine/styles/app_images.dart';
import 'styles/app_colors.dart';
import 'package:mutliline_turing_machine/table/lib/pluto_grid.dart';
import 'dart:developer' as developer;


class TopPanel extends StatefulWidget {
  const TopPanel({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<TopPanel> createState() => _TopPanelState();
}

class _TopPanelState extends State<TopPanel> {
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
                    width: 16,
                    height: 16,
                    child: Image(
                      image: AppImages.file,
                    ),
                  ),
                  style: appButtonStyle,
                ),
              ),
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "Настройки",
                child: ElevatedButton(
                  onPressed: () {},
                  child: const SizedBox(
                    width: 16,
                    height: 16,
                    child: Image(
                      image: AppImages.settings,
                    ),
                  ),
                  style: appButtonStyle,
                ),
              ),
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "О приложении",
                child: ElevatedButton(
                  onPressed: () {},
                  child: const SizedBox(
                    width: 16,
                    height: 16,
                    child: Image(
                      image: AppImages.about,
                    ),
                  ),
                  style: appButtonStyle,
                ),
              ),
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "Справка",
                child: ElevatedButton(
                  onPressed: () {},
                  child: const SizedBox(
                    width: 16,
                    height: 16,
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