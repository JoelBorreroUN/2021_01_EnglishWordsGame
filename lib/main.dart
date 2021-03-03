import 'dart:math';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _word = '';
  int _type = 0, _score = 0, _hightScore = 0;
  final _random = Random();
  int _next(int min, int max) => min + _random.nextInt(max - min);
  void _setRandomWord() {
    var option = _next(0, 2);
    var randomItem = "";
    if (option == 0) {
      print("change to noun");
      randomItem = (nouns.toList()..shuffle()).first;
    } else {
      print("change to adjective");
      randomItem = (adjectives.toList()..shuffle()).first;
    }

    setState(() {
      _word = randomItem;
      _type = option;
    });
  }

  @override
  void initState() {
    super.initState();
    _setRandomWord();
  }

  void _onPressed(int option) {
    setState(() {
      if (option == _type) {
        _score += 1;
        if (_score >= _hightScore) {
          _hightScore = _score;
        }
      } else {
        _score = 0;
      }
    });
    _setRandomWord();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'EWG',
        theme: ThemeData(primarySwatch: Colors.teal),
        home: Scaffold(
            appBar: AppBar(title: Text('English words game')),
            body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Best: $_hightScore'),
                  Text('Score: $_score'),
                  Text('$_word', style: TextStyle(fontSize: 50)),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                            onPressed: () => _onPressed(0),
                            child: Text('Noun',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                            color: Colors.teal),
                        RaisedButton(
                            onPressed: () => _onPressed(1),
                            child: Text('Adjetive',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                            color: Colors.teal)
                      ]),
                  IconButton(
                      icon: Icon(Icons.refresh_outlined, size: 50),
                      onPressed: () {
                        setState(() {
                          _score = 0;
                        });
                        _setRandomWord();
                      })
                ])));
  }
}
