import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Harry Apresentação',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.grey,
      ),
      home: MyHomePage(title: 'Bem-vindo Bruxo(a)'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _reductionCounter() {
    setState(() {
      _counter--;
    });
  }

  String _compareNumber() {
    if (_counter < 0) {
      setState(() {
        _counter = -1;
      });
      return "Você é muito melhor que isso ✌";
    } else if (_counter > 10) {
      setState(() {
        _counter = 11;
      });
      return "Caramba! então você é forte assim? 😎";
    } else {
      return _counter.toString();
    }
  }

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
              Text(
                'O quão poderoso você é?',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 38,
                ),
                textAlign: TextAlign.center,
              ),
              Image.asset(
                "images/varinha.gif",
              ),
              Text(
                'Pressiona os botões para definir o número desejado:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                _compareNumber(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 34,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        floatingActionButton: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: <Widget>[
            Positioned(
                left: 30,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: FloatingActionButton(
                      onPressed: _reductionCounter, child: Icon(Icons.remove)),
                )),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                  onPressed: _incrementCounter, child: Icon(Icons.add)),
            ),
          ],
        ));
  }
}
