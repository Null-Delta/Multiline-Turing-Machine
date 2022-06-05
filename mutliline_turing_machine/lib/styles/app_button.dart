import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mutliline_turing_machine/styles/app_colors.dart';

ButtonStyle appButtonStyle = ButtonStyle(
    elevation: MaterialStateProperty.all(0),
    backgroundColor: MaterialStateProperty.resolveWith(
      (states) {
        if (states.contains(MaterialState.selected)) {
          return AppColors.accent;
        } else if (states.contains(MaterialState.disabled)) {
          return AppColors.highlight;
        } else if (states.contains(MaterialState.hovered)) {
          return AppColors.backgroundDark;
        }
        return AppColors.background;
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
        // if (states.contains(MaterialState.selected)) {
        //   return AppColors.highlight;
        // } else if (states.contains(MaterialState.disabled)) {
        //   return AppColors.highlight;
        // } else if (states.contains(MaterialState.hovered)) {
        //   return AppColors.highlight;
        // }
        return AppColors.highlight;
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

ButtonStyle activeAppButtonStyle = ButtonStyle(
    elevation: MaterialStateProperty.all(0),
    backgroundColor: MaterialStateProperty.resolveWith(
      (states) {
        // if (states.contains(MaterialState.selected)) {
        //   return AppColors.accent;
        // } else if (states.contains(MaterialState.disabled)) {
        //   return AppColors.accent;
        // } else if (states.contains(MaterialState.hovered)) {
        //   return AppColors.accent;
        // }
        return AppColors.accent;
      },
    ),
    foregroundColor: MaterialStateProperty.resolveWith(
      (states) {
        // if (states.contains(MaterialState.selected)) {
        //   return AppColors.background;
        // } else if (states.contains(MaterialState.disabled)) {
        //   return AppColors.background;
        // } else if (states.contains(MaterialState.hovered)) {
        //   return AppColors.background;
        // }
        return AppColors.background;
      },
    ),
    overlayColor: MaterialStateProperty.resolveWith(
      (states) {
        // if (states.contains(MaterialState.selected)) {
        //   return AppColors.background;
        // } else if (states.contains(MaterialState.disabled)) {
        //   return AppColors.background;
        // } else if (states.contains(MaterialState.hovered)) {
        //   return AppColors.background;
        // }
        return AppColors.accent;
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
          return AppColors.background;
        } else if (states.contains(MaterialState.disabled)) {
          return AppColors.background;
        } else if (states.contains(MaterialState.hovered)) {
          return AppColors.background;
        }
        return AppColors.background;
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
          return AppColors.background;
        } else if (states.contains(MaterialState.disabled)) {
          return AppColors.background;
        } else if (states.contains(MaterialState.hovered)) {
          return AppColors.background;
        }
        return AppColors.background;
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
