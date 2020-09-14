import 'package:flutter/widgets.dart';

class Phrase {
  String text;

  TextStyle style;

  Phrase({
    this.text,
    this.style
  });
}

mixin TextDecodeMixin {

  Map<String, String> decodeMap = {'one': '1', 'two': '2', 'three': '3'};

    List<Phrase> decodeTextToStyledPhrase(String text, TextStyle regular, TextStyle marked) {
    var res = <Phrase>[];
    var regExpFilter = RegExp(r'[^\[]+(?=\])');
    var matches = regExpFilter.allMatches(text);
    var matchIndex = 0;
    var startIndex = 0;

    var endIndex = matches.elementAt(matchIndex).start == 0
        ? matches.elementAt(matchIndex).end
        : matches.elementAt(matchIndex).start - 1;
    var currentSubText = text.substring(startIndex, endIndex);

    while (endIndex <= text.length) {
      if (isDecoded(currentSubText)) {
        currentSubText = shortcutToString(currentSubText);
        res.add(Phrase(text: currentSubText, style: marked));
        matchIndex++;
        if (matchIndex < matches.length) {
          startIndex =
              matches.elementAt(matchIndex).start == endIndex + 1 ? matches.elementAt(matchIndex).start : endIndex + 1;
          endIndex =
              endIndex + 1 == startIndex ? matches.elementAt(matchIndex).start - 1 : matches.elementAt(matchIndex).end;
        } else {
          startIndex = endIndex + 1;
          endIndex = text.length;
        }
      } else {
        res.add(Phrase(text: text.substring(startIndex, endIndex), style: regular));
        if(matchIndex < matches.length) {
          startIndex = matches.elementAt(matchIndex).start;
          endIndex = matches.elementAt(matchIndex).end;
        } else {
          break;
        }
      }
      currentSubText = text.substring(startIndex, endIndex);
    }
    return res;
  }

  String shortcutToString(String shortCut) {
    return decodeMap[shortCut] ?? shortCut;
  }

  String returnWordFromString(String text, int start, int end) {
    return text.substring(start, end);
  }

  bool isDecoded(String phrase) {
    return decodeMap[phrase] != null;
  }
}
