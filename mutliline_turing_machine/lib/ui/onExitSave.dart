import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';

bool isOnScreen = false;

Future? onExitSave(context, TuringMachine machine) 
{ 
  if (isOnScreen) {
    return null;
  }
  isOnScreen = true;
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).backgroundColor,
        titleTextStyle: TextStyle(color: Theme.of(context).cardColor, fontSize: 16, fontWeight: FontWeight.w500),
        shape: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(width: 0, color: Colors.transparent),
        ),
        title: const Text('Сохранить файл перед выходом?', textAlign: TextAlign.center,),
        actions: [
          Row(
            children: [
              const Spacer(),
              ElevatedButton(
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
                        initialDirectory: Directory.current.path,
                        lockParentWindow: true,
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
        
                      Navigator.of(context).pop(true);
                    }
                  }
                },
                child: const Text('Сохранить'),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor: MaterialStateProperty.all(Theme.of(context).backgroundColor),
                  foregroundColor: MaterialStateProperty.all(Theme.of(context).cardColor),
                  minimumSize: MaterialStateProperty.all(Size(150, 40)),
                  maximumSize: MaterialStateProperty.all(Size(150, 40)),
                ),
              ),
              //const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Не сохрянять'),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor: MaterialStateProperty.all(Theme.of(context).backgroundColor),
                  foregroundColor: MaterialStateProperty.all(Theme.of(context).cardColor),
                  minimumSize: MaterialStateProperty.all(Size(150, 40)),
                  maximumSize: MaterialStateProperty.all(Size(150, 40)),
                ),
              ),
              //const Spacer(),
              ElevatedButton(
                onPressed: () {
                  isOnScreen = false;
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                },
                child: const Text('Отмена'),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor: MaterialStateProperty.all(Theme.of(context).backgroundColor),
                  foregroundColor: MaterialStateProperty.all(Theme.of(context).cardColor),
                  minimumSize: MaterialStateProperty.all(Size(150, 40)),
                  maximumSize: MaterialStateProperty.all(Size(150, 40)),
                ),
              ),
              const Spacer(),
            ],
          ),
        ],
      );
    }
  );
}