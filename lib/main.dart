import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import 'historyitem.dart';
import 'history.dart';

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
      ),
      home: const MyHomePage(
        title: 'Flutter Demo Home Page',
      ),
    );
  }
}

class Calculation {
  final String x;
  final String t;
  Calculation({
    required this.t,
    required this.x,
  });
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;
  @override
  // State<MyHomePage> createState() => _MyHomePageState();
  _MyHomePageState createState() {
    print("CreateState");
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  String userInput = "";
  String answer = "";

  late List<Calculation> result = [];

  void clean() {
    setState(() {
      userInput = "";
    });
  }

  void add(String s) {
    setState(() {
      userInput += s;
    });
  }

  void delete() {
    if (userInput != "") {
      userInput = userInput.substring(0, userInput.length - 1);
    }
  }

  Parser parser = Parser();
  ContextModel cm = ContextModel();

  void resultCalc() {
    Expression exp = parser.parse(userInput);
    exp.evaluate(EvaluationType.REAL, cm);
    setState(() {
      answer = exp.evaluate(EvaluationType.REAL, cm).toString();
    });
    _incrementHistoryList(answer, userInput);
  }

  @override
  initState() {
    super.initState();
    print("initState");
  }

  void _incrementHistoryList(String answer, String userInput) async {
    final historyItem = Calculation(t: answer, x: userInput);
    result.add(historyItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'History',
            onPressed: () {
              _navigateAndDisplayHistory(context);
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Observer(
              builder: (_) => Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        userInput,
                        //widget.userInput,
                        style: TextStyle(fontSize: 35),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.centerRight,
                      child: Text(
                        answer,
                        //widget.answer,
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
                itemCount: 20,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return Button.orange(
                      label: "AC",
                      onTap: clean,
                    );
                  } else if (index == 1) {
                    return Button.red(
                      label: "DEL",
                      onTap: delete,
                    );
                  } else if (index == 2) {
                    return Button.blue(
                      label: "%",
                      onTap: clean,
                    );
                  } else if (index == 3) {
                    return Button.blue(
                      label: "÷",
                      onTap: () => add("/"),
                    );
                  } else if (index == 4) {
                    return Button.grey(
                      label: "7",
                      onTap: () => add("7"),
                    );
                  } else if (index == 5) {
                    return Button.grey(
                      label: "8",
                      onTap: () => add("8"),
                    );
                  } else if (index == 6) {
                    return Button.grey(
                      label: "9",
                      onTap: () => add("9"),
                    );
                  } else if (index == 7) {
                    return Button.blue(
                      label: "x",
                      onTap: () => add("*"),
                    );
                  } else if (index == 8) {
                    return Button.grey(
                      label: "4",
                      onTap: () => add("4"),
                    );
                  } else if (index == 9) {
                    return Button.grey(
                      label: "5",
                      onTap: () => add("5"),
                    );
                  } else if (index == 10) {
                    return Button.grey(
                      label: "6",
                      onTap: () => add("6"),
                    );
                  } else if (index == 11) {
                    return Button.blue(
                      label: "-",
                      onTap: () => add("-"),
                    );
                  } else if (index == 12) {
                    return Button.grey(
                      label: "1",
                      onTap: () => add("1"),
                    );
                  } else if (index == 13) {
                    return Button.grey(
                      label: "2",
                      onTap: () => add("2"),
                    );
                  } else if (index == 14) {
                    return Button.grey(
                      label: "3",
                      onTap: () => add("3"),
                    );
                  } else if (index == 15) {
                    return Button.blue(
                      label: "+",
                      onTap: () => add("+"),
                    );
                  } else if (index == 16) {
                    return Button.blue(
                      label: "±",
                      onTap: clean,
                    );
                  } else if (index == 17) {
                    return Button.grey(
                      label: "0",
                      onTap: () => add("0"),
                    );
                  } else if (index == 18) {
                    return Button.grey(
                      label: ",",
                      onTap: clean,
                    );
                  } else {
                    return Button.blue(
                      label: "=",
                      onTap: resultCalc,
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }

  void test() {
    log("ABC");
    result.clear();
  }

  Future<void> _navigateAndDisplayHistory(BuildContext context) async {
    final res = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => History(result: result, x: test)),
    );
    if (res != null) {
      setState(() {
        userInput = result[res].x;
        answer = result[res].t;
      });
    }
  }
}

//Button
class Button extends StatelessWidget {
  final onTap;
  Color? bgColor;
  Color? textColor = Colors.white;
  final String? label;
  Button.red({this.label, this.onTap}) {
    bgColor = Colors.red;
  }

  Button.orange({this.label, this.onTap}) {
    bgColor = Colors.deepOrange;
  }

  Button.blue({this.label, this.onTap}) {
    bgColor = Colors.blue;
  }

  Button.grey({this.label, this.onTap}) {
    bgColor = Colors.grey;
    textColor = Colors.black87;
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            color: bgColor,
            child: Center(
              child: Text(
                label!,
                style: TextStyle(color: textColor, fontSize: 25),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
