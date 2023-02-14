import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/styles/app_colors.dart';

ButtonStyle appButtonStyle(BuildContext context) {
  return ButtonStyle(
      elevation: MaterialStateProperty.all(0),
      backgroundColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return Theme.of(context).primaryColor;
          } else if (states.contains(MaterialState.disabled)) {
            return Theme.of(context).highlightColor;
          } else if (states.contains(MaterialState.hovered)) {
            return Theme.of(context).hoverColor;
          }
          return Theme.of(context).colorScheme.background;
        },
      ),
      foregroundColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return Theme.of(context).primaryColor;
          } else if (states.contains(MaterialState.disabled)) {
            return Theme.of(context).disabledColor;
          } else if (states.contains(MaterialState.hovered)) {
            return Theme.of(context).cardColor;
          }
          return Theme.of(context).cardColor;
        },
      ),
      overlayColor: MaterialStateProperty.resolveWith(
        (states) {
          return Theme.of(context).highlightColor;
        },
      ),
      padding: MaterialStateProperty.all(EdgeInsets.zero),
      minimumSize: MaterialStateProperty.all(
        const Size.square(28),
      ),
      fixedSize: MaterialStateProperty.all(
        const Size.square(28),
      ),
      maximumSize: MaterialStateProperty.all(
        const Size.square(28),
      ),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ));
}

activeAppButtonStyle(BuildContext context) => ButtonStyle(
    elevation: MaterialStateProperty.all(0),
    backgroundColor: MaterialStateProperty.resolveWith(
      (states) {
        return Theme.of(context).primaryColor;
      },
    ),
    foregroundColor: MaterialStateProperty.resolveWith(
      (states) {
        return Theme.of(context).colorScheme.background;
      },
    ),
    overlayColor: MaterialStateProperty.resolveWith(
      (states) {
        return Theme.of(context).primaryColor;
      },
    ),
    padding: MaterialStateProperty.all(EdgeInsets.zero),
    minimumSize: MaterialStateProperty.all(
      const Size.square(28),
    ),
    fixedSize: MaterialStateProperty.all(
      const Size.square(28),
    ),
    maximumSize: MaterialStateProperty.all(
      const Size.square(28),
    ),
    shadowColor: MaterialStateProperty.all(Colors.transparent),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
    ));

ButtonStyle linkButtonStyle = ButtonStyle(
    elevation: MaterialStateProperty.all(0),
    backgroundColor: MaterialStateProperty.resolveWith(
      (states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.transparent;
        } else if (states.contains(MaterialState.disabled)) {
          return Colors.transparent;
        } else if (states.contains(MaterialState.hovered)) {
          return Colors.transparent;
        }
        return Colors.transparent;
      },
    ),
    foregroundColor: MaterialStateProperty.resolveWith(
      (states) {
        if (states.contains(MaterialState.selected)) {
          return AppColors.background;
        } else if (states.contains(MaterialState.disabled)) {
          return AppColors.disable;
        } else if (states.contains(MaterialState.hovered)) {
          return AppColors.text;
        }
        return AppColors.text;
      },
    ),
    overlayColor: MaterialStateProperty.resolveWith(
      (states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.transparent;
        } else if (states.contains(MaterialState.disabled)) {
          return Colors.transparent;
        } else if (states.contains(MaterialState.hovered)) {
          return Colors.transparent;
        }
        return Colors.transparent;
      },
    ),
    padding: MaterialStateProperty.all(EdgeInsets.zero),
    textStyle: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.hovered)) {
        return const TextStyle(decoration: TextDecoration.underline);
      } else {
        return const TextStyle();
      }
    }),
    shadowColor: MaterialStateProperty.all(Colors.transparent),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
    ));
