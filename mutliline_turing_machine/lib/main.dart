import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:mutliline_turing_machine/styles/app_button.dart';
import 'styles/app_colors.dart';
import 'package:mutliline_turing_machine/table/lib/pluto_grid.dart';

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
      home: const MyHomePage(title: 'Симулятор Машины Тьюринга'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedRow = -1;
  int selectedColumn = -1;

  int columnsCount = 24;
  int rowsCount = 1000;

  List<PlutoRow> rows = [];
  List<PlutoColumn> columns = [];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < columnsCount; i++) {
      columns.add(
        PlutoColumn(
          cellPadding: 0,
          readOnly: i == 0,
          frozen: i == 0 ? PlutoColumnFrozen.left : PlutoColumnFrozen.none,
          enableContextMenu: false,
          enableSorting: false,
          enableRowDrag: i == 0 ? true : false,
          enableColumnDrag: false,
          textAlign: PlutoColumnTextAlign.center,
          titleTextAlign: PlutoColumnTextAlign.center,
          width: 84,
          minWidth: 64,
          title: i == 0
              ? "Варианты"
              : i == columnsCount - 1
                  ? "Переход"
                  : "Лента $i",
          field: "head:$i",
          type: PlutoColumnType.text(),
        ),
      );
    }

    for (int i = 0; i < rowsCount; i++) {
      rows.add(
        PlutoRow(
          cells: {
            for (int j = 0; j < columnsCount; j++)
              "head:$j": PlutoCell(value: j == 0 ? "№ ${i + 1}" : "_ _ _")
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
              ColoredBox(
                color: AppColors.backgroundDark,
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 4,
                      right: 4,
                    ),
                    height: 36,
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text("."),
                          style: appButtonStyle,
                        )
                      ],
                    ),
                  ),
                  Divider(
                    height: 2,
                    thickness: 2,
                    color: AppColors.highlight,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 84,
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 34,
                                child: Center(
                                  child: Text(
                                    "Состояния",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.text,
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                height: 2,
                                thickness: 2,
                                color: AppColors.highlight,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 2,
                          color: AppColors.highlight,
                        ),
                        Expanded(
                          child: MultiSplitViewTheme(
                            data: MultiSplitViewThemeData(
                              dividerThickness: 2,
                              dividerPainter: DividerPainter(
                                backgroundColor: AppColors.highlight,
                              ),
                            ),
                            child: MultiSplitView(
                              antiAliasingWorkaround: false,
                              axis: Axis.horizontal,
                              resizable: true,
                              minimalSize: 256,
                              initialWeights: const [0.7, 0.3],
                              children: [
                                PlutoGrid(
                                  rows: rows,
                                  columns: columns,
                                  onLoaded: (event) {
                                    event.stateManager.setSelectingMode(
                                        PlutoGridSelectingMode.row);
                                  },
                                  configuration: PlutoGridConfiguration(
                                    rowHeight: 36,
                                    gridBackgroundColor: Colors.transparent,
                                    gridBorderColor: AppColors.highlight,
                                    columnHeight: 36,
                                    enableGridBorderShadow: false,
                                    borderColor: Colors.transparent,
                                    activatedColor: AppColors.backgroundDark,
                                    activatedBorderColor: AppColors.highlight,
                                    enableColumnBorder: false,
                                    cellColorInReadOnlyState:
                                        AppColors.highlight,
                                    inactivatedBorderColor: AppColors.highlight,
                                    iconColor: AppColors.text,
                                    defaultCellPadding: 0,
                                    checkedColor: Colors.redAccent,
                                    enableRowColorAnimation: false,
                                    cellTextStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.text,
                                    ),
                                    columnTextStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.text,
                                    ),
                                  ),
                                ),
                                const ColoredBox(
                                  color: Colors.transparent,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
