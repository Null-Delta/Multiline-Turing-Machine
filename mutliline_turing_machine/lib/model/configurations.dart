import 'line_cell_model.dart';
import 'turing_machine.dart';

class Configuration {
  late List<String> lines;
  late List<int> pointers;

  @override
  bool operator ==(other) {
    bool same = true;
    for (int i = 0; i < lines.length; i++) {
      if (!same) {
        break;
      }
      same = (other as Configuration).lines[i] == lines[i] && same;
    }
    for (int i = 0; i < pointers.length; i++) {
      if (!same) {
        break;
      }
      same = (other as Configuration).pointers[i] == pointers[i] && same;
    }
    return same;
  }

  static List<String> convertConfigurations(List<List<LineCellModel>> lineContent) {
    List<String> lines = [];
    for (int i = 0; i < lineContent.length; i++) {
      String tmpS = "";
      for (int j = 0; j < lineContent[i].length; j++) {
        tmpS += lineContent[i][j].symbol == "" ? "_" : lineContent[i][j].symbol;
      }
      lines.add(tmpS);
    }
    return lines;
  }

  int _hashCode = 0;
  @override
  int get hashCode {
    if (_hashCode == null) {
      for (int i = 0; i < lines.length; i++) {
        _hashCode += lines[i].hashCode + pointers[i].hashCode;
      }
    }
    return _hashCode;
  }

  Configuration(List<String> l, List<int> p) {
    lines = l.toList();
    pointers = p.toList();
  }
}
