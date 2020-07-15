import 'package:flutter/material.dart';
import 'quizbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain qb = new QuizBrain();
void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.black87,
            Colors.teal.shade100,
            Colors.teal.shade300,
            Colors.teal.shade500,
            Colors.teal.shade700
          ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: QuizPage(),
            ),
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
  List<Icon> scoreKeeper = [];

  void checkAns(bool a) {
    setState(() {
      if (qb.isFinished()) {
        var alertStyle = AlertStyle(
          animationType: AnimationType.fromBottom,
          isCloseButton: false,
          isOverlayTapDismiss: false,
          descStyle: TextStyle(fontWeight: FontWeight.normal),
          animationDuration: Duration(milliseconds: 200),
          alertBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(
              color: Colors.blue,
              width: 1.0,
            ),
          ),
          titleStyle: TextStyle(
            color: Colors.black87,
          ),
        );
        Alert(
          context: context,
          style: alertStyle,
          type: AlertType.success,
          title: "Quiz finished",
          desc: "you reached the end of the quiz",
          buttons: [
            DialogButton(
              color: Colors.blue,
              child: Text(
                "OK",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
              radius: BorderRadius.circular(10),
            )
          ],
        ).show();

        qb.reset();
        scoreKeeper = [];
      } else {
        if (qb.getAns() == a) {
          scoreKeeper.add(Icon(
            Icons.add_circle_outline,
            color: Colors.green,
          ));
        } else {
          scoreKeeper.add(Icon(
            Icons.remove_circle_outline,
            color: Colors.red,
          ));
        }
        qb.nextQ();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                qb.getQuesText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              highlightColor: Colors.amber,
              splashColor: Colors.amber,
              textColor: Colors.white,
              color: Colors.greenAccent,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                setState(() {
                  checkAns(true);
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              highlightColor: Colors.amber,
              splashColor: Colors.amber,
              color: Colors.redAccent,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                setState(() {
                  checkAns(false);
                });
              },
            ),
          ),
        ),
        //TODO: Add a Row here as your score keeper
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}

/*
question2: 'Approximately one quarter of human bones are in the feet.',           true,
question1: 'You can lead a cow down stairs but not up stairs.',                   false,
question3: 'A slug\'s blood is green.',                                           true,
*/
