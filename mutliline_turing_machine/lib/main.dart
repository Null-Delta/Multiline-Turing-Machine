import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/model/turing_machine_model.dart';
import 'styles/app_colors.dart';
import 'ui/top_panel.dart';
import 'ui/bottom_panel.dart';
import 'ui/table_page.dart';
import 'dart:developer' as developer;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Симулятор Машины Тьюринга',
      theme: ThemeData(
        fontFamily: "Inter",
        backgroundColor: AppColors.background,
        primarySwatch: MaterialColor(AppColors.accent.value, {
          50: AppColors.accent,
          100: AppColors.accent,
          200: AppColors.accent,
          300: AppColors.accent,
          400: AppColors.accent,
          500: AppColors.accent,
          600: AppColors.accent,
          700: AppColors.accent,
          800: AppColors.accent,
          900: AppColors.accent,
        }),
      ),
      home: MainWidget(),
    );
  }
}

class MainWidget extends StatefulWidget {
  MainWidget({Key? key}) : super(key: key);

  final TuringMachine machine = TuringMachine(TuringMachineModel());

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  @override
  Widget build(BuildContext context) {
    developer.log("${MediaQuery.of(context).devicePixelRatio}");
    return Scaffold(
      body: Center(
        child: MultiSplitViewTheme(
          data: MultiSplitViewThemeData(
            dividerThickness: 2,
            dividerPainter: DividerPainter(
              backgroundColor: AppColors.highlight,
            ),
          ),
          child: MultiSplitView(
            antiAliasingWorkaround: false,
            axis: Axis.vertical,
            minimalSize: 256,
            children: [
              const TopPanel(),
              Column(
                children: const [
                  BottomPanel(),
                  TablePage(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
