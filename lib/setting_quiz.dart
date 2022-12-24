import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gosuoflife/main.dart';
import 'package:gosuoflife/result.dart';
import 'package:gosuoflife/setting_page.dart';
import 'package:vibration/vibration.dart';

import 'market_page.dart';

late StreamSubscription<int> subscription;

int score = 0;
int heart = 0;
int quizTime = 0;

class SettingQuizPage extends StatefulWidget {
  const SettingQuizPage({Key? key}) : super(key: key);

  @override
  State<SettingQuizPage> createState() => _SettingQuizPageState();
}

class _SettingQuizPageState extends State<SettingQuizPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold();
  }
}

void correctDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: ((context) {
        return AlertDialog(
            title: Column(children: [
              Text(
                "정답!",
                style: TextStyle(fontSize: 26),
              ),
            ]),
            actions: <Widget>[
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "다음",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ]);
      }));
}

void IncorrectDialog(BuildContext context, String answer) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: ((context) {
        return AlertDialog(
            title: Column(children: [
              Text(
                "오답!",
                style: TextStyle(fontSize: 26),
              ),
            ]),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(
                "정답 : " + answer,
                style: TextStyle(fontSize: 22),
              ),
            ]),
            actions: <Widget>[
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "다음",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ]);
      }));
}

void ExitDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: ((context) {
        return AlertDialog(
            title: Column(children: [
              Text(
                "그만하기",
                style: TextStyle(fontSize: 26),
              ),
            ]),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(
                "퀴즈 푸는 것을 그만둘까요?",
                style: TextStyle(fontSize: 22),
              ),
            ]),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: ElevatedButton(
                      onPressed: () {
                        StopTimer();
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (BuildContext context,
                                Animation<double> animation1,
                                Animation<double> animation2) {
                              return MarketPage();
                            },
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );
                      },
                      child: Text(
                        "네",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "아니요",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ]);
      }));
}

int GetHeart() {
  heart = prefs.getInt("Heart") ?? 0;
  return heart;
}

void Success(BuildContext context) {
  // ScaffoldMessenger.of(context).clearSnackBars();
  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //   content: Text("정답입니다!"),
  // ));
  correctDialog(context);
}

void Failed(BuildContext context, String answer) {
  if (vibration) Vibration.vibrate(duration: 1000);
  IncorrectDialog(context, answer);
}

class Ticker {
  const Ticker();
  Stream<int> tick({required int ticks}) {
    return Stream.periodic(Duration(seconds: 1), (x) => ticks - x).take(ticks);
  }
}

int GetQuizTime() {
  quizTime = prefs.getInt("QuizTime") ?? 0;
  return quizTime;
}

void EndGame(BuildContext context) {
  StopTimer();
  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation1,
          Animation<double> animation2) {
        return ResultPage();
      },
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
  );
}

void TimeOver(BuildContext context) {
  StopTimer();
  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation1,
          Animation<double> animation2) {
        return ResultPage();
      },
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
  );
}

void HeartOver(BuildContext context) {
  StopTimer();
  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation1,
          Animation<double> animation2) {
        return ResultPage();
      },
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
  );
}

void StopTimer() {
  subscription.cancel();
}
