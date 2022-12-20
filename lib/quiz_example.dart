import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gosuoflife/auth_service.dart';
import 'package:gosuoflife/market_page.dart';
import 'package:gosuoflife/rank_service.dart';
import 'package:gosuoflife/result.dart';
import 'package:gosuoflife/setting_page.dart';
import 'package:gosuoflife/setting_quiz.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';
import 'dart:math';

import 'login_page.dart';
import 'main.dart';

int index = 0;
int maxQuiz = 15;

int? _currentTick;
bool _isPaused = false;

List<int> numberList = [];

List<String> dataList = [
  "",
];

List<String> answerList1 = [
  "",
];
List<String> answerList2 = [
  "",
];
List<String> answerList3 = [
  "",
];

List<String> answer = [
  "",
];

class QuizExample extends StatefulWidget {
  const QuizExample({Key? key}) : super(key: key);

  @override
  State<QuizExample> createState() => _QuizExampleState();
}

class _QuizExampleState extends State<QuizExample> {
  @override
  void initState() {
    super.initState();

    numberList.clear();
    CreateUnDuplicateRandom(dataList.length);

    index = 1;
    score = 0;

    _currentTick = 300;
    _startTimer(300);
  }

  void _startTimer(int duration) {
    subscription = Ticker().tick(ticks: duration).listen((value) {
      if (value <= 1) {
        TimeOver(context);
      }
      setState(() {
        _isPaused = false;
        _currentTick = value;
      });
    });
  }

  void _resumeTimer() {
    setState(() {
      _isPaused = false;
    });
    subscription.resume();
  }

  void _pauseTimer() {
    setState(() {
      _isPaused = true;
    });
    subscription.pause();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("상식 퀴즈"),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                ExitDialog(context);
              },
              icon: Icon(Icons.clear),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "남은 시간 : " + _currentTick.toString(),
                style: TextStyle(fontSize: 26, color: Colors.red),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "$index / 15 번째 문제",
                style: TextStyle(color: Colors.black, fontSize: 36),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "현재 점수 : $score",
                style: TextStyle(color: Colors.black, fontSize: 26),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                dataList[numberList[index - 1]],
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 26),
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    minimumSize: const Size(100, 60),
                  ),
                  onPressed: () {
                    setState(() {
                      if (answerList1[numberList[index - 1]] ==
                          answer[numberList[index - 1]]) {
                        Success(context);
                      } else {
                        Failed(context, answer[numberList[index - 1]]);
                      }
                      Initialize(context);
                    });
                  },
                  child: Text(
                    answerList1[numberList[index - 1]],
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    minimumSize: const Size(100, 60),
                  ),
                  onPressed: () {
                    setState(() {
                      if (answerList2[numberList[index - 1]] ==
                          answer[numberList[index - 1]]) {
                        Success(context);
                      } else {
                        Failed(context, answer[numberList[index - 1]]);
                      }

                      Initialize(context);
                    });
                  },
                  child: Text(
                    answerList2[numberList[index - 1]],
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    minimumSize: const Size(100, 60),
                  ),
                  onPressed: () {
                    setState(() {
                      if (answerList3[numberList[index - 1]] ==
                          answer[numberList[index - 1]]) {
                        Success(context);
                      } else {
                        Failed(context, answer[numberList[index - 1]]);
                      }
                      Initialize(context);
                    });
                  },
                  child: Text(
                    answerList3[numberList[index - 1]],
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void Initialize(BuildContext context) async {
    final user = context.read<AuthService>().currentUser()!;
    if (index > maxQuiz - 1) {
      ScaffoldMessenger.of(context).clearSnackBars();
      int number = prefs.getInt("QuizScore0") ?? 0;
      if (score > number) {
        if (number == 0) {
          rankService.create(QuizType.Quiz1, "NickName", score, user.uid);
        } else {
          rankService.update(QuizType.Quiz1, "NickName", score, user.uid);
        }
        prefs.setInt("QuizScore0", score);
      }

      StopTimer();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResultPage(score)),
      );
    } else {
      index++;
    }
  }
}

void CreateUnDuplicateRandom(int max) {
  int currentNumber = Random().nextInt(max);

  for (int i = 0; i < max;) {
    if (numberList.contains(currentNumber)) {
      currentNumber = Random().nextInt(max);
    } else {
      numberList.add(currentNumber);
      i++;
    }
  }
}
