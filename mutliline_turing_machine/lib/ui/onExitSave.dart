import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:path_provider/path_provider.dart';

bool isOnScreen = false;

Future? onExitSave(context, TuringMachine machine) async {
  if (isOnScreen) {
    return null;
  }
  isOnScreen = true;
  var res = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          titleTextStyle: TextStyle(
              color: Theme.of(context).cardColor,
              fontSize: 16,
              fontWeight: FontWeight.w500),
          shape: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            borderSide: BorderSide(width: 0, color: Colors.transparent),
          ),
          title: Container(
            constraints: const BoxConstraints(minWidth: double.infinity),
            child: const Text(
              'Сохранить файл перед выходом?',
              textAlign: TextAlign.center,
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (machine.filePath != null) {
                        File file = File(machine.filePath!);
                        IOSink sink = file.openWrite();
                        String json = jsonEncode(machine.toJson());
                        sink.write(json);
                        file.create();
                        Navigator.of(context).pop(true);
                      } else {
                        String? result = await FilePicker.platform.saveFile(
                            initialDirectory: Platform.isWindows
                                ? (await getApplicationDocumentsDirectory())
                                        .path +
                                    "\\Multiline Turing Machine Saves"
                                : (await getApplicationDocumentsDirectory())
                                        .path +
                                    "/Multiline Turing Machine Saves",
                            dialogTitle: '',
                            fileName: 'save.mmt',
                            type: FileType.custom,
                            allowedExtensions: ['mmt']);

                        if (result != null) {
                          if (result.contains('.')) {
                            log("message " + result.indexOf('.').toString());
                            result = result.substring(0, result.indexOf('.'));
                          }
                          result += '.mmt';
                          log(result);

                          File file = File(result);
                          IOSink sink = file.openWrite();
                          String json = jsonEncode(machine.toJson());
                          sink.write(json);
                          file.create();

                          machine.filePath = result;
                        }
                      }
                    },
                    child: const SizedBox(
                      height: 24,
                      width: 120,
                      child: Center(
                          child: AutoSizeText(
                        "Сохранить",
                        maxLines: 1,
                        minFontSize: 4,
                      )),
                    ),
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.background),
                      foregroundColor: MaterialStateProperty.all(
                          Theme.of(context).cardColor),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const SizedBox(
                      height: 24,
                      width: 120,
                      child: Center(
                          child: AutoSizeText(
                        "Не сохрянять",
                        maxLines: 1,
                        minFontSize: 4,
                      )),
                    ),
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.background),
                      foregroundColor: MaterialStateProperty.all(
                          Theme.of(context).cardColor),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                    },
                    child: const SizedBox(
                      height: 24,
                      width: 120,
                      child: Center(
                          child: AutoSizeText(
                        "Отмена",
                        maxLines: 1,
                        minFontSize: 4,
                      )),
                    ),
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.background),
                      foregroundColor: MaterialStateProperty.all(
                          Theme.of(context).cardColor),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      });
  isOnScreen = false;
  return res;
}
