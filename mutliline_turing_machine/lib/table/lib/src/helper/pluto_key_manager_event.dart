import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlutoKeyManagerEvent {
  FocusNode focusNode;
  RawKeyEvent event;

  PlutoKeyManagerEvent({
    required this.focusNode,
    required this.event,
  });
}

extension PlutoKeyManagerEventExtention on PlutoKeyManagerEvent {
  bool get isKeyDownEvent => event.runtimeType == RawKeyDownEvent;

  bool get isKeyUpEvent => event.runtimeType == RawKeyUpEvent;

  bool get isMoving => isHorizontal || isVertical;

  bool get isHorizontal => isLeft || isRight;

  bool get isVertical => isUp || isDown;

  bool get isLeft =>
      event.logicalKey.keyId == LogicalKeyboardKey.arrowLeft.keyId;

  bool get isRight =>
      event.logicalKey.keyId == LogicalKeyboardKey.arrowRight.keyId;

  bool get isUp => event.logicalKey.keyId == LogicalKeyboardKey.arrowUp.keyId;

  bool get isDown =>
      event.logicalKey.keyId == LogicalKeyboardKey.arrowDown.keyId;

  bool get isHome => event.logicalKey.keyId == LogicalKeyboardKey.home.keyId;

  bool get isEnd => event.logicalKey.keyId == LogicalKeyboardKey.end.keyId;

  bool get isPageUp {
    // windows 에서 pageUp keyId 가 0x10700000021.
    return event.logicalKey.keyId == LogicalKeyboardKey.pageUp.keyId ||
        event.logicalKey.keyId == 0x10700000021;
  }

  bool get isPageDown {
    // windows 에서 pageDown keyId 가 0x10700000022.
    return event.logicalKey.keyId == LogicalKeyboardKey.pageDown.keyId ||
        event.logicalKey.keyId == 0x10700000022;
  }

  bool get isEsc => event.logicalKey.keyId == LogicalKeyboardKey.escape.keyId;

  bool get isEnter => event.logicalKey.keyId == LogicalKeyboardKey.enter.keyId;

  bool get isTab => event.logicalKey.keyId == LogicalKeyboardKey.tab.keyId;

  bool get isF2 => event.logicalKey.keyId == LogicalKeyboardKey.f2.keyId;

  bool get isF3 => event.logicalKey.keyId == LogicalKeyboardKey.f3.keyId;

  bool get isBackspace =>
      event.logicalKey.keyId == LogicalKeyboardKey.backspace.keyId;

  bool get isShift =>
      event.logicalKey.keyId == LogicalKeyboardKey.shift.keyId ||
      event.logicalKey.keyId == LogicalKeyboardKey.shiftLeft.keyId ||
      event.logicalKey.keyId == LogicalKeyboardKey.shiftRight.keyId;

  bool get isControl =>
      event.logicalKey.keyId == LogicalKeyboardKey.control.keyId ||
      event.logicalKey.keyId == LogicalKeyboardKey.controlLeft.keyId ||
      event.logicalKey.keyId == LogicalKeyboardKey.controlRight.keyId;

  bool get isCharacter => characters.contains(event.logicalKey.keyId);

  bool get isCtrlC {
    return isCtrlPressed &&
            event.logicalKey.keyId == LogicalKeyboardKey.keyC.keyId ||
        event.logicalKey.keyId == 0x0000000441;
  }

  bool get isCtrlV {
    return isCtrlPressed &&
            event.logicalKey.keyId == LogicalKeyboardKey.keyV.keyId ||
        event.logicalKey.keyId == 0x000000043c;
  }

  bool get isCtrlA {
    return isCtrlPressed &&
        event.logicalKey.keyId == LogicalKeyboardKey.keyA.keyId;
  }

  bool get isShiftPressed {
    return event.isShiftPressed;
  }

  bool get isCtrlPressed {
    return event.isMetaPressed || event.isControlPressed;
  }

  bool get isAltPressed {
    return event.isAltPressed;
  }
}

const characters = [
  0x0000000410, //А
  0x0000000411, //Б
  0x0000000412, //В
  0x0000000413, //Г
  0x0000000414, //Д
  0x0000000415, //Е
  0x0000000416, //Ж
  0x0000000417, //З
  0x0000000418, //И
  0x0000000419, //Й
  0x000000041a, //К
  0x000000041b, //Л
  0x000000041c, //М
  0x000000041d, //Н
  0x000000041e, //О
  0x000000041f, //П
  0x0000000420, //Р
  0x0000000421, //С
  0x0000000422, //Т
  0x0000000423, //У
  0x0000000424, //Ф
  0x0000000425, //Х
  0x0000000426, //Ц
  0x0000000427, //Ч
  0x0000000428, //Ш
  0x0000000429, //Щ
  0x000000042a, //Ъ
  0x000000042b, //Ы
  0x000000042c, //Ь
  0x000000042d, //Э
  0x000000042e, //Ю
  0x000000042f, //Я
  0x000000002a, //*
  0x0000000430, //а
  0x0000000431, //б
  0x0000000432, //в
  0x0000000433, //г
  0x0000000434, //д
  0x0000000435, //е
  0x0000000436, //ж
  0x0000000437, //з
  0x0000000438, //и
  0x0000000439, //й
  0x000000043a, //к
  0x000000043b, //л
  0x000000043c, //м
  0x000000043d, //н
  0x000000043e, //о
  0x000000043f, //п
  0x0000000440, //р
  0x0000000441, //с
  0x0000000442, //т
  0x0000000443, //у
  0x0000000444, //ф
  0x0000000445, //х
  0x0000000446, //ц
  0x0000000447, //ч
  0x0000000448, //ш
  0x0000000449, //щ
  0x000000044a, //ъ
  0x000000044b, //ы
  0x000000044c, //ь
  0x000000044d, //э
  0x000000044e, //ю
  0x000000044f, //я

  0x000000005f, //_

  0x0000000041, // keyA,
  0x0000000042, // keyB,
  0x0000000043, // keyC,
  0x0000000044, // keyD,
  0x0000000045, // keyE,
  0x0000000046, // keyF,
  0x0000000047, // keyG,
  0x0000000048, // keyH,
  0x0000000049, // keyI,
  0x000000004a, // keyJ,
  0x000000004b, // keyK,
  0x000000004c, // keyL,
  0x000000004d, // keyM,
  0x000000004e, // keyN,
  0x000000004f, // keyO,
  0x0000000050, // keyP,
  0x0000000051, // keyQ,
  0x0000000052, // keyR,
  0x0000000053, // keyS,
  0x0000000054, // keyT,
  0x0000000055, // keyU,
  0x0000000056, // keyV,
  0x0000000057, // keyW,
  0x0000000058, // keyX,
  0x0000000059, // keyY,
  0x000000005a, // keyZ,
  0x0000000061, // keyA,
  0x0000000062, // keyB,
  0x0000000063, // keyC,
  0x0000000064, // keyD,
  0x0000000065, // keyE,
  0x0000000066, // keyF,
  0x0000000067, // keyG,
  0x0000000068, // keyH,
  0x0000000069, // keyI,
  0x000000006a, // keyJ,
  0x000000006b, // keyK,
  0x000000006c, // keyL,
  0x000000006d, // keyM,
  0x000000006e, // keyN,
  0x000000006f, // keyO,
  0x0000000070, // keyP,
  0x0000000071, // keyQ,
  0x0000000072, // keyR,
  0x0000000073, // keyS,
  0x0000000074, // keyT,
  0x0000000075, // keyU,
  0x0000000076, // keyV,
  0x0000000077, // keyW,
  0x0000000078, // keyX,
  0x0000000079, // keyY,
  0x000000007a, // keyZ,
  0x0000000031, // digit1,
  0x0000000032, // digit2,
  0x0000000033, // digit3,
  0x0000000034, // digit4,
  0x0000000035, // digit5,
  0x0000000036, // digit6,
  0x0000000037, // digit7,
  0x0000000038, // digit8,
  0x0000000039, // digit9,
  0x0000000030, // digit0,
  0x0000000020, // space,
  0x000000002d, // minus,
  0x000000003d, // equal,
  0x000000005b, // bracketLeft,
  0x000000005d, // bracketRight,
  0x000000005c, // backslash,
  0x000000003b, // semicolon,
  0x0000000027, // quote,
  0x0000000060, // backquote,
  0x000000002c, // comma,
  0x000000002e, // period,
  0x000000002f, // slash,
  0x0100070054, // numpadDivide,
  0x0100070055, // numpadMultiply,
  0x0100070056, // numpadSubtract,
  0x0100070057, // numpadAdd,
  0x0100070059, // numpad1,
  0x010007005a, // numpad2,
  0x010007005b, // numpad3,
  0x010007005c, // numpad4,
  0x010007005d, // numpad5,
  0x010007005e, // numpad6,
  0x010007005f, // numpad7,
  0x0100070060, // numpad8,
  0x0100070061, // numpad9,
  0x0100070062, // numpad0,
  0x0100070063, // numpadDecimal,
  0x0100070064, // intlBackslash,
  0x0100070067, // numpadEqual,
  0x0100070085, // numpadComma,
  0x0100070087, // intlRo,
  0x0100070089, // intlYen,
  0x01000700b6, // numpadParenLeft,
  0x01000700b7, // numpadParenRight,
];
