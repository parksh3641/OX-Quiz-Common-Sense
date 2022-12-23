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
int score = 0;
int heart = 0;
int maxQuiz = 15;

var _controller = TextEditingController();

int? _currentTick;
bool _isPaused = false;

String levelType = "";
String levelStr = "";

List<int> numberList = [];

List<String> dataList = [
  "ㅎㄹㅇ",
  "ㅋㄱㄹ",
  "ㅇㄹㅁ",
  "ㅂㅇㅇ",
  "ㅅㅋㅇ",
  "ㅁㄷㅈ",
  "ㅋㄲㄹ",
  "ㅇㅅㅇ",
  "ㄱㅇㅇ",
  "ㅁㅇㅋ",
  "ㄷㄹㅈ",
  "ㅎㅇㅇㄴ",
  "ㅇㄹㅇㅌ",
  "ㅈㅂㄱㄹ",
  "ㄴㅁㄴㅂ",
  "ㅊㄷㅇㄹ",
  "흰ㅅㅇㄱㄹ",
  "하ㄴㄷㄹㅈ",
  "오ㄹㄴㄱㄹ",
  "반ㄷㄱㅅㄱ",
  "목ㄷㄹㄷㅁㅂ",
  "시ㅂㄹㅇㅎㄹㅇ"
];

List<String> answer = [
  "호랑이",
  "캥거루",
  "얼룩말",
  "부엉이",
  "살쾡이",
  "멧돼지",
  "코끼리",
  "원숭이",
  "고양이",
  "미어캣",
  "다람쥐",
  "하이에나",
  "오랑우탄",
  "직박구리",
  "나무늘보",
  "청둥오리",
  "흰수염고래",
  "하늘다람쥐",
  "오리너구리",
  "반달가슴곰",
  "목도리도마뱀",
  "시베리아호랑이"
];

class Quiz6 extends StatefulWidget {
  const Quiz6({Key? key}) : super(key: key);

  @override
  State<Quiz6> createState() => _Quiz6State();
}

class _Quiz6State extends State<Quiz6> {
  @override
  void initState() {
    super.initState();

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

  @override
  void dispose() {
    super.dispose();
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Text(
              "초성 퀴즈 [동물] (" + levelStr + ")",
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  ExitDialog(context);
                },
                icon: Icon(Icons.dangerous),
              ),
            ],
          ),
          body: GestureDetector(
            onTap: (() => FocusScope.of(context).unfocus()),
            child: SingleChildScrollView(
              child: Padding(
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
                        style: TextStyle(color: Colors.black, fontSize: 36),
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
                      TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '정답 입력',
                        ),
                        onSubmitted: (text) {
                          if (text == answer[numberList[index - 1]]) {
                            Success(context);
                            score++;
                          } else {
                            Failed(context, answer[numberList[index - 1]]);
                            MinusHeart(context);
                          }
                          _controller.text = "";
                          Initialize(context);
                        },
                      )
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

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
  int number = prefs.getInt("QuizScore" + levelType + "5") ?? 0;
  if (score > number) {
    prefs.setInt("QuizScore" + levelType + "5", score);
  }

  prefs.setInt("Score", score);
}
