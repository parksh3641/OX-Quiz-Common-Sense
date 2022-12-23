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
  "불로장생을 꿈꿔 전 세계를 뒤져 불로초를 찾았던 왕의 이름은?",
  "평창동계올림픽이 열렸던 해는 몇 년도인가요?",
  "제주도는 삼다도라고 불리기도 하는데 삼다에 해당되는 것은?",
  "국보 1호였던 문화재의 이름은?",
  "우리나라 최초의 한글 소설로 전해지는 이 고전소설의 이름은?",
  "물건을 구입하거나, 각종 서비스를 제공받을 때 그 가격에 일정비율 붙게 하는 세금은?",
  "e-mail의 e는 무엇의 약자일까?",
  "지구 온난화의 주범이자 소가 내뿜는 가스는?",
  "우리 몸에 필요한 3대 영양소가 아닌것은?",
  "세계 최초로 달에 착륙한 사람은?",
  "우체국 로고에 있는 새는 무엇일까요?",
  "인류 최초의 감미료라고 불리며 이집트에서는 미라 보존을 위해 방부제로 사용한 것은?",
  "낙타 혹 안에 들어있는 것은?",
  "훈민정음 창제 당시 자음과 모음의 글자 수는?",
  "조선시대 자격루를 발명한 사람은?",
  "세계에서 가장 넓은 나라는?",
  "순결, 변함없는 사랑의 꽃말을 가진 꽃은?",
  "백조의 호수를 작곡한 차이코프스키는 어느나라의 작곡가일까요?",
  "다음 중 '동계올림픽'의 종목이 아닌것은?",
  "대한민국에서 가장 큰 섬은?",
  "글피는 며칠 후를 나타낸 말일까?",
  "화력발전에서 가장 많이 사용되는 연료는 무엇일까?",
  "소리의 측정 단위는 무엇일까?"
];

List<String> answerList1 = [
  "진시황",
  "2017년",
  "감귤",
  "동대문",
  "까치전",
  "관세",
  "energy",
  "질소",
  "비타민",
  "루이 암스트롱",
  "비둘기",
  "꿀",
  "단백질",
  "26자",
  "장영실",
  "중국",
  "해바라기",
  "러시아",
  "스키점프",
  "독도",
  "2일",
  "석유",
  "dB(데시벨)"
];
List<String> answerList2 = [
  "혜문왕",
  "2018년",
  "여자",
  "남대문",
  "홍길동전",
  "개별소비세",
  "entertainer",
  "이산화탄소",
  "지방",
  "닐 암스트롱",
  "참새",
  "설탕",
  "탄수화물",
  "28자",
  "김종서",
  "러시아",
  "장미",
  "오스트리아",
  "트라이애슬론",
  "울릉도",
  "5일",
  "석탄",
  "yd(야드)"
];
List<String> answerList3 = [
  "효문왕",
  "2019년",
  "흑돼지",
  "숭례문",
  "춘향전",
  "부가가치세",
  "electronic",
  "메탄",
  "탄수화물",
  "아폴로",
  "까치",
  "소금",
  "지방",
  "30자",
  "황희",
  "미국",
  "백합",
  "독일",
  "스켈레톤",
  "제주도",
  "3일",
  "LPG",
  "ft(피트)"
];

List<String> answer = [
  "진시황",
  "2018년",
  "여자",
  "숭례문",
  "홍길동전",
  "부가가치세",
  "electronic",
  "메탄",
  "비타민",
  "닐 암스트롱",
  "까치",
  "꿀",
  "지방",
  "28자",
  "장영실",
  "러시아",
  "백합",
  "러시아",
  "트라이애슬론",
  "제주도",
  "3일",
  "석탄",
  "dB(데시벨)"
];

class Quiz1 extends StatefulWidget {
  const Quiz1({Key? key}) : super(key: key);

  @override
  State<Quiz1> createState() => _Quiz1State();
}

class _Quiz1State extends State<Quiz1> {
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
            title: Text(
              "상식 퀴즈 (" + levelStr + ")",
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
  int number = prefs.getInt("QuizScore" + levelType + "0") ?? 0;
  if (score > number) {
    prefs.setInt("QuizScore" + levelType + "0", score);
  }

  prefs.setInt("Score", score);
}
