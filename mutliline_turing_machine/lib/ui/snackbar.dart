
import 'package:flutter/material.dart';
import 'package:material_snackbar/snackbar.dart';
import 'package:material_snackbar/snackbar_messenger.dart';


class Snackbar {

  
  static void create(
      String text,
      bool isError,
      BuildContext context) {
    if(MaterialSnackBarMessenger.snackbarQueue.length < 3)
    {
      MaterialSnackBarMessenger.of(context).showSnackBar(
        snackbar: MaterialSnackbar(
          theme: SnackBarThemeData(
              shape: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6),
                  ),
                  borderSide: BorderSide(color: Colors.transparent, width: 0)),
              backgroundColor: !isError
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).errorColor,
              actionTextColor: Theme.of(context).backgroundColor,
              contentTextStyle:
                  TextStyle(color: Theme.of(context).backgroundColor)),
          content: Text(
            text,
            style: TextStyle(color: Theme.of(context).backgroundColor),
          ),
        ),
        alignment: Alignment.bottomRight);
    }
  }
}
