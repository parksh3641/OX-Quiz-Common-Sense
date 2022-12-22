import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gosuoflife/main.dart';
import 'package:gosuoflife/result.dart';
import 'package:gosuoflife/setting_page.dart';
import 'package:vibration/vibration.dart';

import 'market_page.dart';

late StreamSubscription<int> subscription;

int score = 0;

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

void IncorrectDialog(BuildContext context, String answer) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: ((context) {
        return AlertDialog(
            title: Column(children: <Widget>[
              Text(
                "오답!",
                style: TextStyle(fontSize: 26),
              ),
            ]),
            content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "정답 : " + answer,
                    style: TextStyle(fontSize: 22),
                  ),
                ]),
            actions: <Widget>[
              Container(
                width: double.infinity,
                height: 50,
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
            title: Column(children: <Widget>[
              Text(
                "중단하기",
                style: TextStyle(fontSize: 26),
              ),
            ]),
            content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "퀴즈를 종료할까요?",
                    style: TextStyle(fontSize: 22),
                  ),
                ]),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 120,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        StopTimer();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MarketPage()),
                        );
                      },
                      child: Text(
                        "네",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 50,
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

void Success(BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text("정답입니다!"),
  ));
  score++;
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

void TimeOver(BuildContext context) {
  StopTimer();
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ResultPage(score)),
  );
}

void StopTimer() {
  subscription.cancel();
}
