import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:apresentacao/services/data/cep_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Harry Potter e a Apresentação',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.white,
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
  final _formKey = GlobalKey<FormState>();
  int _power = 0;

  void _incrementCounter() {
    setState(() {
      _power++;
    });
  }

  void _reductionCounter() {
    setState(() {
      _power--;
    });
  }

  String _compareNumber() {
    if (_power < 0) {
      setState(() {
        _power = -1;
      });
      return "Você é muito melhor que isso ✌";
    } else if (_power > 10) {
      setState(() {
        _power = 11;
      });
      return "Caramba! então você é forte assim? 😎";
    } else {
      return _power.toString();
    }
  }

  void _safeDataOnDisk(name, age, power) async {
    print('$name, $age, $power');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('power', _power);
    await prefs.setString('name', name);
    await prefs.setString('age', age);
    print(
        'Seu nome é ${prefs.getString('name')}, sua idade é ${prefs.getString('age')} e seu poder é de ${prefs.getInt('power')}/10.');
  }

  @override
  Widget build(BuildContext context) {
    String name;
    String age;
    String cep;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Form(
            key: _formKey,
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
                TextFormField(
                  onSaved: (String value) {
                    name = value;
                  },
                  textAlign: TextAlign.center,
                  decoration:
                      const InputDecoration(hintText: 'Digite seu nome'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Por favor digite seu nome';
                    }
                    return null;
                  },
                ),
                TextFormField(
                    onSaved: (String value) {
                      age = value;
                    },
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Digite sua idade',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Por favor digite sua idade';
                      } else if (int.parse(value) < 18) {
                        return 'Este sistema somente para maiores de idade';
                      }
                      return null;
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ]),
                TextFormField(
                    onSaved: (String value) {
                      cep = value;
                    },
                    maxLength: 8,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Digite seu cep',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Por favor digite seu cep';
                      }
                      return null;
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ]),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        CepService().searchCep(cep);
                        _safeDataOnDisk(name, age, _power);
                      }
                    },
                    child: Text('Enviar'),
                  ),
                ),
              ],
            ),
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
