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
  "달팽이도 이빨이 있다",
  "지하철 1량 (칸)에는 출입문이 모두 8개이다",
  "세계에서 제일 처음으로 텔레비전 방송을 시작한 나라는 영국이다",
  "말도 잠을 잘 때는 사람과 같이 코를 곤다",
  "셰익스피어 희곡 햄릿의 주인공인 햄릿은 네덜란드 사람이다",
  "바늘 한 쌍은 모두 22개이다",
  "북두칠성은 시계의 반대 방향으로 회전한다",
  "게의 다리는 모두 10개이다.",
  "열대 지방에 자라는 나무에는 나이테가 없다",
  "늑대는 개 과, 호랑이는 고양이과에 속한다. 닭은 꿩과에 속한다",
  "벼룩은 암컷과 수컷 가운데 수컷의 몸집이 더 크다",
  "딸기는 장미과에 속한다",
  "아라비아 숫자 1부터 100사이에는 9라는 숫자가 모두 19개 들어 있다",
  "금강산은 경치가 아름다워 4계절마다 불리우는 이름이 다르다",
  "병아리도 배꼽이 있다",
  "전쟁시 여자아이보다 남자아이의 출생률이 높다",
  "채찍이라는 뜻을 가진 '람바다'는 브라질 춤이다",
  "밀물과 썰물 현상은 하루 2번씩 일어난다",
  "고추 1관은 5Kg 이다",
  "조선시대 호패는 (주민등록증) 16세 이상 모든 남녀가 소지했다",
  "인간의 뇌 세포는 재생이 안 되는 신체세포이다",
  "사람의 5가지 (시각, 후각, 미각, 청각, 촉각) 충에서 가장 먼저 나빠지는 감각기관은 시각이다",
  "물고기도 기침을 한다",
  "사슴뿔은 매년 빠졌다 다시 난다",
  "사람의 땀은 산성이다",
  "색소폰은 그 이름이 최초의 연주자 이름으로부터 유래된 것이다",
  "로댕의 생각하는 사람은 오른손으로 턱을 받치고 있다",
  "고대 원시인들의 가장 큰 적은 공룡이었다",
  "남자와 여자의 목소리 중 멀리 들리는 것은 여자 목소리다",
  "탱고의 고장은 '아르헨티나'다",
  "빵은 순수한 우리말이다",
  "북쪽을 가리키는 별은 북극성, 남쪽을 가리키는 별은 남십자성이다",
  "난중일기는 이순신 장군이 전사하기 한달 전까지 기록되어있다",
  "백설공주에 나오는 일곱 난쟁이의 직업은 광부였다",
  "서울 마사회 과천 경마장 정문 앞의 말 동상은 숫말이다",
  "버스의 무임 승차 나이는 6세 미만이다",
  "BUS라는 단어는 미국에서 처음 사용하였다",
  "꺼벙이란 꿩의 새끼를 말한다",
  "가장 강한 독을 가진 개구리 1마리의 독으로 사람을 2000명 이상을 죽일 수 있다",
  "머리를 자주 감으면 머리카락이 빠진다",
  "닭도 왼발잡이, 오른발잡이가 있다",
  "색맹도 색깔이 있는 꿈을 꿀 수가 있다",
  "사마귀가 있는 사람과 키스를 하면 자신도 사마귀가 생긴다",
  "개발에도 땀이 난다",
  "새는 뒤로도 날 수 있다",
  "남극을 갈 때도 비자가 필요하다",
  "위가 없어도 사람은 살 수 있다"
];

List<String> answer = [
  "O",
  "O",
  "O",
  "O",
  "X",
  "X",
  "O",
  "O",
  "O",
  "O",
  "X",
  "O",
  "X",
  "O",
  "O",
  "O",
  "O",
  "O",
  "X",
  "X",
  "O",
  "O",
  "O",
  "O",
  "O",
  "O",
  "O",
  "X",
  "O",
  "O",
  "O",
  "O",
  "O",
  "O",
  "O",
  "O",
  "X",
  "O",
  "O",
  "X",
  "O",
  "X",
  "O",
  "X",
  "O",
  "X",
  "O"
];

class Quiz4 extends StatefulWidget {
  const Quiz4({Key? key}) : super(key: key);

  @override
  State<Quiz4> createState() => _Quiz4State();
}

class _Quiz4State extends State<Quiz4> {
  @override
  void initState() {
    super.initState();

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
              "OX 퀴즈 (" + levelStr + ")",
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  ExitDialog(context);
                },
                icon: Icon(Icons.cancel),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                      if ("O" == answer[numberList[index - 1]]) {
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
                    "O",
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
                      if ("X" == answer[numberList[index - 1]]) {
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
                    "X",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ]),
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
  int number = prefs.getInt("QuizScore" + levelType + "3") ?? 0;
  if (score > number) {
    prefs.setInt("QuizScore" + levelType + "3", score);
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
