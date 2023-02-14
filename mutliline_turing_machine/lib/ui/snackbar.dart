import 'package:flutter/material.dart';
import 'package:material_snackbar/snackbar.dart';
import 'package:material_snackbar/snackbar_messenger.dart';

class Snackbar {
  static void create(String text, BuildContext context,
      {bool isError = true, double sec = 2}) {
    if (MaterialSnackBarMessenger.snackbarQueue.isEmpty) {
      MaterialSnackBarMessenger.of(context).showSnackBar(
          snackbar: MaterialSnackbar(
            theme: SnackBarThemeData(
                shape: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(6),
                    ),
                    borderSide:
                        BorderSide(color: Colors.transparent, width: 0)),
                backgroundColor: !isError
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).colorScheme.error,
                actionTextColor: Theme.of(context).colorScheme.background,
                contentTextStyle:
                    TextStyle(color: Theme.of(context).colorScheme.background)),
            content: Text(
              text,
              style: TextStyle(color: Theme.of(context).colorScheme.background),
            ),
            duration: Duration(milliseconds: (sec * 1000).toInt()),
          ),
          alignment: Alignment.bottomRight);
    }
  }
}
