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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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

  int columnsCount = 10;
  int rowsCount = 240;

  List<PlutoRow> rows = [];
  List<PlutoColumn> columns = [];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < columnsCount; i++) {
      columns.add(
        PlutoColumn(
          readOnly: i == 0,
          frozen: i == 0 ? PlutoColumnFrozen.left : PlutoColumnFrozen.none,
          enableContextMenu: false,
          enableSorting: false,
          enableRowDrag: i == 0 ? true : false,
          enableColumnDrag: false,
          textAlign: PlutoColumnTextAlign.center,
          titleTextAlign: PlutoColumnTextAlign.center,
          width: i == 0 ? 80 : 64,
          minWidth: 64,
          title: i == 0 ? "Варианты" : "Лента $i",
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
              "head:$j": PlutoCell(value: j == 0 ? "№ $i" : "")
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
                      color: Color(0xFFF4F4FB),
                    ),
                  ),
                  Expanded(
                    child: PlutoGrid(
                      rows: rows,
                      columns: columns,
                      onLoaded: (event) {
                        event.stateManager
                            .setSelectingMode(PlutoGridSelectingMode.row);
                        //event.stateManager
                      },
                      configuration: const PlutoGridConfiguration(
                          rowHeight: 32,
                          gridBackgroundColor: Color(0xFFFDFDFF),
                          gridBorderColor: Color(0xFFF4F4FB),
                          columnHeight: 36,
                          enableGridBorderShadow: false,
                          borderColor: Colors.transparent,
                          activatedColor: Color(0xFFF4F4FB),
                          activatedBorderColor: Color(0xFFE7E8F3),
                          enableColumnBorder: false,
                          cellTextStyle: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.normal),
                          columnTextStyle: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold)),
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
