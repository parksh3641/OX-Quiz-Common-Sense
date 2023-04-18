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
  "라ㄹㄹㄷ",
  "ㄱㅅㅊ",
  "웰ㅋㅌㄷㅁㄱ",
  "박ㅁㄱㅇㅅㄹㅇㄷ",
  "신ㄱㅎㄲ",
  "극ㅎㅈㅇ",
  "완ㅂㅎㅌㅇ",
  "ㅇㅈㅆ",
  "수ㅅㅎㄱㄴ",
  "ㅇㄹㄷ",
  "아ㅂㅌ",
  "타ㅇㅌㄴ",
  "스ㅍㅇㄷㅁ",
  "어ㅂㅈㅅ",
  "라ㅇㅇㅋ",
  "ㅁㄹ",
  "겨ㅇㅇㄱ",
  "도ㄷㄷ",
  "ㅇㅅ",
  "ㅂㅌㄹ",
  "광ㅎㅇㅇㄷㄴㅈ",
  "택ㅅㅇㅈㅅ",
  "ㅂㅅㅎ",
  "ㄱㅁ",
  "인ㅌㅅㅌㄹ",
  "검ㅅㅇㅈ",
  "ㅇㅅㅌ",
  "ㄱㅅ",
  "설ㄱㅇㅊ",
  "내ㅂㅈㄷ",
  "아ㅇㅇㅁ",
  "수ㅅㅎㄱㄴ",
  "과ㅅㅅㅋㄷ",
  "국ㄱㄷㅍ",
  "트ㄹㅅㅍㅁ",
  "ㅆㄴ",
  "ㅌㄴ",
  "ㅅㄹ",
  "태ㄱㄱㅎㄴㄹㅁ",
  "ㅇㅇㄴㅈ",
  "ㅎㅇㄷ"
];

List<String> answer = [
  "라라랜드",
  "기생충",
  "웰컴투동막골",
  "박물관이살아있다",
  "신과함께",
  "극한직업",
  "완벽한타인",
  "아저씨",
  "수상한그녀",
  "알라딘",
  "아바타",
  "타이타닉",
  "스파이더맨",
  "어벤져스",
  "라이온킹",
  "명량",
  "겨울왕국",
  "도둑들",
  "암살",
  "베테랑",
  "광해왕이된남자",
  "택시운전사",
  "부산행",
  "괴물",
  "인터스텔라",
  "검사외전",
  "엑시트",
  "관상",
  "설국열차",
  "내부자들",
  "아이언맨",
  "수상한그녀",
  "과속스캔들",
  "국가대표",
  "트랜스포머",
  "써니",
  "터널",
  "쉬리",
  "태극기휘날리며",
  "왕의남자",
  "해운대"
];

class Quiz5 extends StatefulWidget {
  const Quiz5({Key? key}) : super(key: key);

  @override
  State<Quiz5> createState() => _Quiz5State();
}

class _Quiz5State extends State<Quiz5> {
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
            backgroundColor: Colors.white,
            title: Text(
              "초성 퀴즈 [영화] (" + levelStr + ")",
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
  int number = prefs.getInt("QuizScore" + levelType + "4") ?? 0;
  if (score > number) {
    prefs.setInt("QuizScore" + levelType + "4", score);
  }

  prefs.setInt("Score", score);
}
