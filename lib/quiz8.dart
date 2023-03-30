import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
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

late AssetsAudioPlayer _success = AssetsAudioPlayer.newPlayer();
late AssetsAudioPlayer _fail = AssetsAudioPlayer.newPlayer();

int index = 0;
int score = 0;
int heart = 0;
int maxQuiz = 15;

int? _currentTick;
bool _isPaused = false;

String levelType = "";
String levelStr = "";

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

class Quiz8 extends StatefulWidget {
  const Quiz8({Key? key}) : super(key: key);

  @override
  State<Quiz8> createState() => _Quiz8State();
}

class _Quiz8State extends State<Quiz8> {
  @override
  void initState() {
    super.initState();

    _success.setVolume(0.7);

    _success.open(
      Audio("assets/audios/Success.mp3"),
      loopMode: LoopMode.none,
      autoStart: false,
      showNotification: false,
    );

    _fail.open(
      Audio("assets/audios/Fail.wav"),
      loopMode: LoopMode.none,
      autoStart: false,
      showNotification: false,
    );

    numberList.clear();
    CreateUnDuplicateRandom(dataList.length);

    index = 1;
    score = 0;

    levelType = prefs.getString("LevelType") ?? "Easy";

    switch (levelType) {
      case "Easy":
        heart = 3 + GetHeart();
        _currentTick = 300 + GetQuizTime();
        _startTimer(300 + GetQuizTime());
        levelStr = "쉬움";
        break;
      case "Normal":
        heart = 2 + GetHeart();
        _currentTick = 200 + GetQuizTime();
        _startTimer(200 + GetQuizTime());
        levelStr = "보통";
        break;
      case "Hard":
        heart = 1 + GetHeart();
        _currentTick = 100 + GetQuizTime();
        _startTimer(100 + GetQuizTime());
        levelStr = "어려움";
        break;
    }
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
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Text(
              "MBTI 퀴즈 (" + levelStr + ")",
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  ExitDialog(context);
                },
                icon: Icon(
                  Icons.cancel,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  ("♥" * heart),
                  style: TextStyle(fontSize: 30, color: Colors.red),
                ),
                Text(
                  "남은 시간 : " + _currentTick.toString(),
                  style: TextStyle(fontSize: 22, color: Colors.red),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "$index / 15 번째 문제",
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "현재 점수 : $score",
                  style: TextStyle(color: Colors.black, fontSize: 22),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  width: double.infinity,
                  child: Column(children: [
                    Text(
                      dataList[numberList[index - 1]],
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 22),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 60,
                ),
                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      minimumSize: const Size(400, 60),
                    ),
                    onPressed: () {
                      setState(() {
                        if (answerList1[numberList[index - 1]] ==
                            answer[numberList[index - 1]]) {
                          Success(context);
                          score++;
                          PlaySuccess();
                        } else {
                          PlayFail();
                          Failed(context, answer[numberList[index - 1]]);
                          MinusHeart(context);
                        }
                        Initialize(context);
                      });
                    },
                    child: Text(
                      textAlign: TextAlign.center,
                      answerList1[numberList[index - 1]],
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      minimumSize: const Size(400, 60),
                    ),
                    onPressed: () {
                      setState(() {
                        if (answerList2[numberList[index - 1]] ==
                            answer[numberList[index - 1]]) {
                          Success(context);
                          score++;
                          PlaySuccess();
                        } else {
                          PlayFail();
                          Failed(context, answer[numberList[index - 1]]);
                          MinusHeart(context);
                        }

                        Initialize(context);
                      });
                    },
                    child: Text(
                      textAlign: TextAlign.center,
                      answerList2[numberList[index - 1]],
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      minimumSize: const Size(400, 60),
                    ),
                    onPressed: () {
                      setState(() {
                        if (answerList3[numberList[index - 1]] ==
                            answer[numberList[index - 1]]) {
                          Success(context);
                          score++;
                          PlaySuccess();
                        } else {
                          PlayFail();
                          Failed(context, answer[numberList[index - 1]]);
                          MinusHeart(context);
                        }

                        Initialize(context);
                      });
                    },
                    child: Text(
                      textAlign: TextAlign.center,
                      answerList3[numberList[index - 1]],
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //final user = context.read<AuthService>().currentUser()!;
  // if (number == 0) {
  //   rankService.create(QuizType.Quiz1, "NickName", score, user.uid);
  // } else {
  //   rankService.update(QuizType.Quiz1, "NickName", score, user.uid);
  // }

  void Initialize(BuildContext context) async {
    if (index > maxQuiz - 1) {
      ScaffoldMessenger.of(context).clearSnackBars();
      SaveHighScore();
      EndGame(context);
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

void MinusHeart(BuildContext context) {
  heart--;

  if (heart <= 0) {
    ScaffoldMessenger.of(context).clearSnackBars();
    SaveHighScore();
    HeartOver(context);
  }
}

void SaveHighScore() {
  int number = prefs.getInt("QuizScore" + levelType + "7") ?? 0;
  if (score > number) {
    prefs.setInt("QuizScore" + levelType + "7", score);
  }

  prefs.setInt("Score", score);
}

void PlaySuccess() {
  _success.stop();
  _success.play();
}

void PlayFail() {
  _fail.stop();
  _fail.play();
}
