import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';

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
        primarySwatch: Colors.red,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MultiSplitViewTheme(
          child: MultiSplitView(
            axis: Axis.vertical,
            children: [
              const ColoredBox(color: Colors.red),
              MultiSplitViewTheme(
                child: MultiSplitView(
                  axis: Axis.horizontal,
                  children: const [
                    ColoredBox(color: Colors.green),
                    ColoredBox(color: Colors.blue),
                  ],
                  minimalSize: 256,
                ),
                data: MultiSplitViewThemeData(dividerThickness: 3.0),
              ),
            ],
            minimalSize: 256,
          ),
          data: MultiSplitViewThemeData(dividerThickness: 3.0),
        ),
      ),
    );
  }
}
