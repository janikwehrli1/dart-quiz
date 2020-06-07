import 'package:flutter/material.dart';
import 'questiondata.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> checkSymbols = [];
  int correctanswers = 0;
/*  List<String> questions = [
    'You can lead a cow down stairs but not up stairs.',
    'Approximately one quarter of human bones are in the feet.',
    'A slug\'s blood is green.'
  ];
  List<bool> answers = [false, true, true];*/

  void checkAnswer(bool rightorfalse) {
    bool checkanswer = allquestions.getQuestionAnswer();
    if (checkanswer == rightorfalse) {
      checkSymbols.add(Icon(
        Icons.check,
        color: Colors.green,
      ));
      correctanswers++;
    } else {
      checkSymbols.add(Icon(
        Icons.close,
        color: Colors.red,
      ));
    }
    if (allquestions.isFinished() == true) {
      Alert(
              context: context,
              title: "Ende des Quizzes",
              desc:
                  "Das Spiel ist vorbei du hast $correctanswers/13 richtig beantwortet")
          .show();
      checkSymbols = [];
      allquestions.reset();
      correctanswers = 0;
    }
  }

  Questiondata allquestions = Questiondata();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Text(
                allquestions.getQuestionText(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
              color: Colors.green,
              textColor: Colors.white,
              child: Center(
                child: Text(
                  'True',
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
              onPressed: () {
                checkAnswer(true);
                setState(() {
                  allquestions.nextquestion();
                });
              },
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
              color: Colors.red,
              textColor: Colors.white,
              child: Center(
                child: Text(
                  'False',
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
              onPressed: () {
                checkAnswer(false);
                setState(() {
                  allquestions.nextquestion();
                });
              },
            ),
          ),
        ),
        Row(
          children: checkSymbols,
        ),
      ],
    );
  }
}
