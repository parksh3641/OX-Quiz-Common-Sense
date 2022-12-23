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

int? _currentTick;
bool _isPaused = false;

String levelType = "";
String levelStr = "";

List<int> numberList = [];

List<String> dataList = [
  "스웨덴의 수도는?",
  "말레이시아의 수도는?",
  "독일의 수도는?",
  "중국의 수도는?",
  "가나의 수도는?",
  "프랑스의 수도는?",
  "스페인의 수도는?",
  "헝가리의 수도는?",
  "룩셈부르크의 수도는?",
  "불가리아의 수도는?",
  "멕시코의 수도는?",
  "베네수엘라의 수도는?",
  "쿠바의 수도는?",
  "영국의 수도는?",
  "러시아의 수도는?",
  "태국의 수도는?",
  "덴마크의 수도는?",
  "브라질의 수도는?",
  "스페인의 수도는?",
  "대한민국의 수도는?",
  "일본의 수도는?",
  "체코의 수도는?",
  "그리스의 수도는?",
  "이집트의 수도는?"
];

List<String> answerList1 = [
  "함마르비",
  "쿠알라룸푸르",
  "뭔헨",
  "상하이",
  "쿠마시",
  "파리",
  "바르셀로나",
  "부쿠레슈티",
  "릴",
  "베오그라드",
  "칸쿤",
  "보고타",
  "포르토프랭스",
  "웰링턴",
  "블라디보스톡",
  "치앙마이",
  "코펜하겐",
  "마드리드",
  "마드리드",
  "도쿄",
  "아테네",
  "부다페스트",
  "아테네",
  "알렌산드리아"
];
List<String> answerList2 = [
  "스톡홀름",
  "마닐라",
  "프랑크푸르트",
  "타이베이",
  "타말",
  "니스",
  "마드리드",
  "부다페스트",
  "룩셈부르크",
  "소피아",
  "멕시코시티",
  "로조우",
  "킹스턴",
  "더블린",
  "모스크바",
  "방콕",
  "상파울루",
  "상파울루",
  "프라하",
  "서울",
  "카이로",
  "프라하",
  "테살로니키",
  "쿠알라룸푸르"
];
List<String> answerList3 = [
  "코펜하겐",
  "코타키나발루",
  "베를린",
  "베이징",
  "아크라",
  "리옹",
  "그라나다",
  "리스본",
  "크노케",
  "부큐레슈티",
  "리마",
  "카라카스",
  "하바나",
  "런던",
  "상트페테르부르크",
  "미얀마",
  "더블린",
  "브라질리아",
  "바르셀로나",
  "베이징",
  "도쿄",
  "테살로니키",
  "카이로",
  "카이로"
];

List<String> answer = [
  "스톡홀름",
  "쿠알라룸푸르",
  "베를린",
  "베이징",
  "아크라",
  "파리",
  "마드리드",
  "부다페스트",
  "룩셈부르크",
  "소피아",
  "멕시코시티",
  "카라카스",
  "하바나",
  "런던",
  "모스크바",
  "방콕",
  "코펜하겐",
  "브라질리아",
  "마드리드",
  "서울",
  "도쿄",
  "프라하",
  "아테네",
  "카이로"
];

class Quiz3 extends StatefulWidget {
  const Quiz3({Key? key}) : super(key: key);

  @override
  State<Quiz3> createState() => _Quiz3State();
}

class _Quiz3State extends State<Quiz3> {
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
              "수도 퀴즈 (" + levelStr + ")",
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
                        } else {
                          Failed(context, answer[numberList[index - 1]]);
                          MinusHeart(context);
                        }
                        Initialize(context);
                      });
                    },
                    child: Text(
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
                        } else {
                          Failed(context, answer[numberList[index - 1]]);
                          MinusHeart(context);
                        }

                        Initialize(context);
                      });
                    },
                    child: Text(
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
                        } else {
                          Failed(context, answer[numberList[index - 1]]);
                          MinusHeart(context);
                        }
                        Initialize(context);
                      });
                    },
                    child: Text(
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
  int number = prefs.getInt("QuizScore" + levelType + "2") ?? 0;
  if (score > number) {
    prefs.setInt("QuizScore" + levelType + "2", score);
  }

  prefs.setInt("Score", score);
}
