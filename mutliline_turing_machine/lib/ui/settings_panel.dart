import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/styles/app_button.dart';
import 'package:mutliline_turing_machine/styles/app_images.dart';
import 'package:mutliline_turing_machine/ui/machine_inherit.dart';
import 'package:provider/provider.dart';

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
  const SettingsPanel({Key? key}) : super(key: key);

  @override
  State<SettingsPanel> createState() => _SettingsPanel();
}

class _SettingsPanel extends State<SettingsPanel> {
  static const double iconSize = 28;
  late TuringMachine machine;
  var innerValue = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<LineAnimationState>(builder: (_, value, __) {
      innerValue = value.isAnimate;

      return DefaultTextStyle(
        style: const TextStyle(),
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 6,
                ),
                height: 40,
                color: Theme.of(context).backgroundColor,
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
                    color: Theme.of(context).backgroundColor,
                    child: Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 640),
                        child: Container(
                          padding: const EdgeInsets.only(left: 32, right: 32, top: 16, bottom: 16),
                          color: Theme.of(context).backgroundColor,
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
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      value.setState(!value.isAnimate);
                                    },
                                    child: Text(
                                      value.isAnimate ? "Вкл" : "Выкл",
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                ],
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
      );
    });
  }
}
