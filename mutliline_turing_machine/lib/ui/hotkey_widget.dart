import 'package:flutter/material.dart';

class HotKeyWidget extends StatefulWidget {
  const HotKeyWidget({Key? key, required this.name, required this.hotKey})
      : super(key: key);

  final String name;
  final List<String> hotKey;

  @override
  State<HotKeyWidget> createState() => _HotKeyWidgetState();
}

class _HotKeyWidgetState extends State<HotKeyWidget> {
  var isHovered = false;

  Widget hotKeyTitle(List<String> words) {
    List<Text> components = [];

    for (int i = 0; i < words.length; i++) {
      components.add(
        Text(
          words[i],
          style: TextStyle(
              color: Theme.of(context).cardColor,
              fontWeight: FontWeight.w500,
              fontSize: 14),
        ),
      );
      components.add(
        Text(
          " + ",
          style: TextStyle(
              color: Theme.of(context).cardColor.withOpacity(0.3),
              fontWeight: FontWeight.w400,
              fontSize: 14),
        ),
      );
    }

    components.removeLast();

    return Row(
      children: components,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHovered = false;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isHovered
              ? Theme.of(context).hoverColor
              : Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        margin: const EdgeInsets.only(left: 20, right: 20),
        padding: const EdgeInsets.only(left: 12, right: 12),
        constraints: const BoxConstraints(maxWidth: 640),
        height: 32,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                    color: Theme.of(context).cardColor.withOpacity(0.6),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                hotKeyTitle(widget.hotKey),
              ],
            )
          ],
        ),
      ),
    );
  }
}
