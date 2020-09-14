import 'package:flutter/material.dart';
import 'package:rischtextexampl/text_decode_mixin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'RichText + RegExp + decode'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TextDecodeMixin {
  Widget res;

  final String textToDecode1 = 'Lets go to [one] stair, turn back and press [two], after that go to pont [three]. '
      'Done!';

  final String textToDecode2 = '[one] stair, turn back and press [two], after that go to pont [three]';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(textToDecode2),
            res != null ? res : Container(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => runDecode(),
        tooltip: 'Run test',
        child: Icon(Icons.airplanemode_active),
      ),
    );
  }

  runDecode() {
    print('runDecode');
    setState(() {
      res = shortcutsTextToWidget(
          text: textToDecode2,
          fontSize: 16,
          isShortCutsBold: true,
          shortCutsColor: Colors.red,
          textColor: Colors.indigo,
          textAlign: TextAlign.center);
    });
  }

  Widget shortcutsTextToWidget({
    String text = '',
    Color textColor,
    Color shortCutsColor,
    bool isShortCutsBold,
    TextAlign textAlign,
    double fontSize,
  }) {
    var regularTextStyle = TextStyle(
      fontSize: fontSize,
      color: textColor,
    );

    var markedTextStyle = TextStyle(
      fontSize: fontSize,
      color: shortCutsColor,
      fontWeight: isShortCutsBold ? FontWeight.bold : FontStyle.normal,
    );
    var markedText = decodeTextToStyledPhrase(text, regularTextStyle, markedTextStyle);

    return RichText(
      textAlign: textAlign,
      text: TextSpan(
          text: markedText.elementAt(0).text,
          style: markedText.elementAt(0).style,
          children: markedText.sublist(1).map((phrase) => TextSpan(text: phrase.text, style: phrase.style)).toList()),
    );
  }
}
