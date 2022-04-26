import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/model/machine_engine.dart';
import 'package:mutliline_turing_machine/styles/app_colors.dart';
import 'package:mutliline_turing_machine/styles/app_images.dart';
import 'package:provider/provider.dart';

class ConfigurationCounter extends StatefulWidget {
  const ConfigurationCounter({Key? key}) : super(key: key);

  @override
  State<ConfigurationCounter> createState() => _ConfigurationCounterState();
}

class _ConfigurationCounterState extends State<ConfigurationCounter> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ConfigurationSet>(builder: (_, value, __) {
      return Tooltip(
        message: "Количество конфигураций",
        waitDuration: const Duration(milliseconds: 500),
        child: Container(
          padding: const EdgeInsets.only(left: 4),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              color: AppColors.backgroundDark,
              border: Border.all(color: AppColors.highlight, width: 2)),
          width: 72,
          height: 28,
          child: Row(
            children: [
              const Image(
                width: 24,
                height: 24,
                image: AppImages.arrowRight,
              ),
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: double.infinity),
                  child: Text(
                    "${value.countConfigurations}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
            ],
          ),
        ),
      );
    });
  }
}
