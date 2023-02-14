import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/styles/app_button.dart';
import 'package:mutliline_turing_machine/styles/app_images.dart';
import 'package:provider/provider.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_theme.dart';

class LineAnimationState extends ChangeNotifier {
  bool isAnimate = true;

  LineAnimationState(bool initValue) {
    isAnimate = initValue;
  }

  void setState(bool animate) {
    isAnimate = animate;
    notifyListeners();
  }
}

class SettingsPanel extends StatefulWidget {
  const SettingsPanel({Key? key, required this.theme}) : super(key: key);

  final AppTheme theme;
  @override
  State<SettingsPanel> createState() => _SettingsPanel();
}

class _SettingsPanel extends State<SettingsPanel> {
  static const double iconSize = 28;
  late TuringMachine machine;
  var innerValue = true;
  var useSystemTheme = false;
  var prefs = SharedPreferences.getInstance();
  var selectedTheme = 0;

  @override
  void initState() {
    super.initState();

    prefs.then((value) {
      setState(() {
        useSystemTheme = value.getBool("use_system_theme") ?? true;
        selectedTheme = value.getInt("selected_theme") ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LineAnimationState>(builder: (_, value, __) {
      innerValue = value.isAnimate;

      return Scaffold(
        body: DefaultTextStyle(
          style: const TextStyle(),
          child: Container(
            color: Theme.of(context).colorScheme.background,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: 6,
                  ),
                  height: 40,
                  color: Theme.of(context).colorScheme.background,
                  child: Row(
                    children: [
                      Tooltip(
                        waitDuration: const Duration(milliseconds: 500),
                        message: "Выход",
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            if (value.isAnimate != innerValue) {
                              value.setState(innerValue);
                            }
                          },
                          child: SizedBox(
                            width: iconSize,
                            height: iconSize,
                            child: Image(
                              image: AppImages.back,
                              color: Theme.of(context).cardColor,
                            ),
                          ),
                          style: appButtonStyle(context),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Настройки",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Theme.of(context).cardColor,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 2,
                  thickness: 2,
                  color: Theme.of(context).highlightColor,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      color: Theme.of(context).colorScheme.background,
                      child: Center(
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 640),
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 32, right: 32, top: 16, bottom: 16),
                            color: Theme.of(context).colorScheme.background,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Анимация лент",
                                        style: TextStyle(
                                          color: Theme.of(context).cardColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    FlutterSwitch(
                                        activeColor:
                                            Theme.of(context).primaryColor,
                                        inactiveColor:
                                            Theme.of(context).highlightColor,
                                        activeToggleColor: Colors.white,
                                        inactiveToggleColor: Theme.of(context)
                                            .colorScheme
                                            .background,
                                        height: 28,
                                        width: 48,
                                        toggleSize: 20,
                                        value: value.isAnimate,
                                        onToggle: (isToggle) {
                                          value.setState(!value.isAnimate);
                                        }),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Использовать системную тему",
                                        style: TextStyle(
                                          color: Theme.of(context).cardColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    FlutterSwitch(
                                        activeColor:
                                            Theme.of(context).primaryColor,
                                        inactiveColor:
                                            Theme.of(context).highlightColor,
                                        activeToggleColor: Colors.white,
                                        inactiveToggleColor: Theme.of(context)
                                            .colorScheme
                                            .background,
                                        height: 28,
                                        width: 48,
                                        toggleSize: 20,
                                        value: useSystemTheme,
                                        onToggle: (isToggle) {
                                          setState(() {
                                            useSystemTheme = !useSystemTheme;
                                            if (!useSystemTheme) {
                                              prefs.then((value) {
                                                selectedTheme = value.getInt(
                                                        "selected_theme") ??
                                                    0;
                                                widget.theme.setMode(
                                                    useSystemTheme
                                                        ? 0
                                                        : selectedTheme + 1);
                                              });
                                              prefs.then((value) {
                                                value.setBool(
                                                    "use_system_theme",
                                                    useSystemTheme);
                                              });
                                            } else {
                                              widget.theme.setMode(
                                                  useSystemTheme
                                                      ? 0
                                                      : selectedTheme + 1);
                                              prefs.then((value) {
                                                value.setBool(
                                                    "use_system_theme",
                                                    useSystemTheme);
                                              });
                                            }
                                          });
                                        }),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Visibility(
                                  visible: !useSystemTheme,
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              selectedTheme = 0;
                                              widget.theme.setMode(
                                                  useSystemTheme
                                                      ? 0
                                                      : selectedTheme + 1);
                                              prefs.then((value) {
                                                value.setInt("selected_theme",
                                                    selectedTheme);
                                              });
                                            },
                                            child: SizedBox(
                                              width: 200,
                                              height: 150,
                                              child: Image.asset(
                                                  'resources/images/3.0x/light_preview.png'),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Radio<int>(
                                                  splashRadius: -10,
                                                  value: 0,
                                                  groupValue: selectedTheme,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectedTheme = value!;
                                                    });

                                                    prefs.then((value) {
                                                      value.setInt(
                                                          "selected_theme",
                                                          selectedTheme);
                                                    });
                                                    widget.theme.setMode(
                                                        useSystemTheme
                                                            ? 0
                                                            : selectedTheme +
                                                                1);
                                                  }),
                                              Text("Светлая тема",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .cardColor)),
                                            ],
                                          )
                                        ],
                                      ),
                                      const Spacer(),
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              selectedTheme = 1;
                                              widget.theme.setMode(
                                                  useSystemTheme
                                                      ? 0
                                                      : selectedTheme + 1);
                                              prefs.then((value) {
                                                value.setInt("selected_theme",
                                                    selectedTheme);
                                              });
                                            },
                                            child: SizedBox(
                                              width: 200,
                                              height: 150,
                                              child: Image.asset(
                                                  'resources/images/3.0x/dark_preview.png'),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Radio<int>(
                                                  splashRadius: -10,
                                                  value: 1,
                                                  groupValue: selectedTheme,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectedTheme = value!;
                                                    });
                                                    prefs.then((value) {
                                                      value.setInt(
                                                          "selected_theme",
                                                          selectedTheme);
                                                    });
                                                    widget.theme.setMode(
                                                        useSystemTheme
                                                            ? 0
                                                            : selectedTheme +
                                                                1);
                                                  }),
                                              Text("Темная тема",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .cardColor)),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
