import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomPopup extends StatefulWidget {
  const CustomPopup(
      {Key? key,
      required this.itemBuilder,
      required this.child,
      required this.initValue,
      required this.onSelected,
      this.tooltip})
      : super(key: key);

  final List<PopupMenuItem<dynamic>> Function(BuildContext) itemBuilder;
  final void Function(dynamic) onSelected;
  final String? tooltip;
  final Widget child;
  final dynamic initValue;

  @override
  State<CustomPopup> createState() => _CustomPopupState();
}

class _CustomPopupState extends State<CustomPopup> {
  FocusNode focus = FocusNode();
  bool isMouseInButton = false;

  var state = GlobalKey<PopupMenuButtonState>();

  @override
  Widget build(BuildContext context) {
    return Focus(
      descendantsAreFocusable: false,
      focusNode: focus,
      onKey: (node, event) {
        if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
          state.currentState!.showButtonMenu();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      onFocusChange: (value) {
        setState(() {});
      },
      child: PopupMenuButton(
        color: Theme.of(context).colorScheme.background,
        tooltip: widget.tooltip,
        key: state,
        elevation: 12,
        offset: Offset.zero,
        initialValue: widget.initValue,
        enableFeedback: true,
        onSelected: (value) {
          widget.onSelected(value);
        },
        shape: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(width: 0, color: Colors.transparent),
        ),
        itemBuilder: widget.itemBuilder,
        child: MouseRegion(
          onEnter: (event) {
            setState(() {
              isMouseInButton = true;
            });
          },
          onExit: (event) {
            setState(() {
              isMouseInButton = false;
            });
          },
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              color: focus.hasFocus || isMouseInButton
                  ? Theme.of(context).highlightColor
                  : Theme.of(context).colorScheme.background,
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
