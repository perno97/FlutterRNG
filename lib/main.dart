import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final fromController = TextEditingController();
  final toController = TextEditingController();
  String _randomNumber = "-";
  int _from = -1;
  int _to = -1;
  bool ready = true;

  Future<void> _generateRandomNumber() async {
    if(ready) {
      ready = false;
      setState(() {
        _randomNumber = "-";
      });
      await Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          if(fromController.text.length != 0)
            _from = int.parse(fromController.text);
          if(toController.text.length != 0)
            _to = int.parse(toController.text);
          int minimum = min(_from,_to);
          int maximum = max(_from,_to);
          int number = minimum + Random.secure().nextInt(maximum - minimum + 1);
          if(number >= 0)
            _randomNumber = number.toString();
          ready = true;
        });
      });
    }
  }

  @override
  void dispose(){
    fromController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "$_randomNumber",
                  style: Theme.of(context).textTheme.display4.apply(fontSizeFactor: 1.5, fontWeightDelta: 5),
                )
              ],
            )
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: fromController,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          decoration: new InputDecoration(
                            labelText: "Da",
                            labelStyle: TextStyle(
                              color: Colors.white
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)
                            )
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4)
                          ],
                        )
                      )
                    ),
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: toController,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            decoration: new InputDecoration(
                              labelText: "A",
                              labelStyle: TextStyle(
                                  color: Colors.white
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)
                              )
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4)
                            ],
                          )
                        )
                    )
                  ],
                ),
                FlatButton(
                  onPressed: () {
                    _generateRandomNumber();
                  },
                  child: Text(
                      "Lancia"
                  ),
                )
              ],
            )
          )
        ],
      )
    );
  }
}
