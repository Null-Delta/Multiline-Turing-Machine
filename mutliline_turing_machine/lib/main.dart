import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';
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
        primarySwatch: const MaterialColor(0xFF72A5B5, {
          50: Color(0xFF72A5B5),
          100: Color(0xFF72A5B5),
          200: Color(0xFF72A5B5),
          300: Color(0xFF72A5B5),
          400: Color(0xFF72A5B5),
          500: Color(0xFF72A5B5),
          600: Color(0xFF72A5B5),
          700: Color(0xFF72A5B5),
          800: Color(0xFF72A5B5),
          900: Color(0xFF72A5B5),
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
          width: 80,
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
              dividerPainter:
                  DividerPainter(backgroundColor: const Color(0xFFE7E8F3))),
          child: MultiSplitView(
            antiAliasingWorkaround: false,
            axis: Axis.vertical,
            minimalSize: 256,
            children: [
              const ColoredBox(
                color: Color(0xFFF4F4FB),
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 36,
                    child: ColoredBox(
                      color: Color(0xFFFDFDFF),
                    ),
                  ),
                  const Divider(
                    height: 2,
                    thickness: 2,
                    color: Color(0xFFE7E8F3),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          color: Colors.transparent,
                          child: Column(
                            children: const [
                              SizedBox(
                                height: 30,
                                child: Center(
                                  child: Text(
                                    "Состояния",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                height: 2,
                                thickness: 2,
                                color: Color(0xFFE7E8F3),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 2,
                          color: const Color(0xFFE7E8F3),
                        ),
                        Expanded(
                          child: MultiSplitViewTheme(
                            data: MultiSplitViewThemeData(
                              dividerThickness: 2,
                              dividerPainter: DividerPainter(
                                backgroundColor: const Color(0xFFE7E8F3),
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
                                  configuration: const PlutoGridConfiguration(
                                      rowHeight: 32,
                                      gridBackgroundColor: Colors.transparent,
                                      gridBorderColor: Color(0xFFE7E8F3),
                                      columnHeight: 32,
                                      enableGridBorderShadow: false,
                                      borderColor: Colors.transparent,
                                      activatedColor: Color(0xFFF4F4FB),
                                      activatedBorderColor: Color(0xFFE7E8F3),
                                      enableColumnBorder: false,
                                      cellColorInReadOnlyState:
                                          Color(0xFFF4F4FB),
                                      inactivatedBorderColor: Color(0xFFE7E8F3),
                                      iconColor: Color(0xFF183157),
                                      defaultCellPadding: 0,
                                      checkedColor: Colors.redAccent,
                                      enableRowColorAnimation: false,
                                      cellTextStyle: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal),
                                      columnTextStyle: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold)),
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
