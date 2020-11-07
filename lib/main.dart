import 'package:calculatorapp/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var userquestion = '';
  var useranswer = '';
  final textstyle = TextStyle(fontSize: 30, color: Colors.deepPurple);

  final List<String> buttons = [
    'c',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    '*',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text(userquestion)),
                  Container(
                      alignment: Alignment.centerRight,
                      child: Text(useranswer)),
                ],
              ),
            )),
            Expanded(
              flex: 2,
              child: Container(
                child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return MyButton(
                          buttontapped: () {
                            setState(() {
                              userquestion = '';
                              useranswer = '';
                            });
                            ;
                          },
                          textcolor: Colors.deepPurple,
                          color: Colors.green,
                          buttontext: buttons[index],
                        );
                      } else if (index == 1) {
                        return MyButton(
                          buttontapped: () {
                            setState(() {
                              userquestion = userquestion.substring(
                                  0, userquestion.length - 1);
                            });
                          },
                          textcolor: Colors.white,
                          color: Colors.red,
                          buttontext: buttons[index],
                        );
                      } else if (index == buttons.length-1) {
                        return MyButton(
                          buttontapped: () {
                            setState(() {
                             equalpress();
                             userquestion='';
                            });
                          },
                          textcolor: Colors.white,
                          color: Colors.red,
                          buttontext: buttons[index],
                        );
                      } else {
                        return MyButton(
                          buttontapped: () {
                            setState(() {
                              userquestion = userquestion + buttons[index];
                            });
                          },
                          buttontext: buttons[index],
                          color: isoperator(buttons[index])
                              ? Colors.deepPurple
                              : Colors.deepPurple[50],
                          textcolor: isoperator(buttons[index])
                              ? Colors.white
                              : Colors.deepPurple,
                        );
                      }
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool isoperator(String x) {
    if (x == '%' || x == '/' || x == '-' || x == '=' || x == '+' || x == '*') {
      return true;
    }
    return false;
  }
  void equalpress(){
    String finalquestion = userquestion;
  Parser p = Parser();
  Expression exp = p.parse(finalquestion);
  ContextModel cm = ContextModel();
  double eval = exp.evaluate(EvaluationType.REAL, cm);
  useranswer = eval.toString();
  }
}
