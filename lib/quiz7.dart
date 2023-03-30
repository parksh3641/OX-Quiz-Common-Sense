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
  "다음 중 '갓생'에서 갓이 의미하는 것은?",
  "다음 중 '캘박'의 뜻 풀이로 옳은 것은?",
  "다음 중 '점메추'가 가장 필요한 사람은?",
  "다음 중 '웃안웃'의 뜻 풀이로 옳은 것은?",
  "다음 중 '왜요, 제가 ㅇㅇ한 사람처럼 생겼나요?'의 유래가 된 문장은?",
  "다음 중 'OO매매법'의 성격이 다른 하나는?",
  "다음 중 '식집사'에게 특히나 곤란한 상황은?",
  "다음 중 'ae(아이)'와 관련 있는 아이돌 그룹은?",
  "Z세대가 활용하는 '여름이었다'의 의미와 가장 가까운 영화 장르는?",
  "다음 중 '드르륵 탁'의 유래로 알맞은 것은?",
  "다음 중 '깡'의 의미가 다른 하나는?",
  "다음 중 '무슨 일이야?'라는 의미를 가진 것은?",
  "다음 중 사귀기 전 썸 단계를 말하는 것은?",
  "다음 중 '어쩔티비'를 받아칠 수 있는 것은?",
  "다음 중 '무불보'의 뜻으로 옳바른 것은?",
  "다음 중 '저메추'의 뜻으로 옳바른 것은?",
  "다음 중 '알잘딱깔센'의 뜻으로 옳바른 것은?",
  "다음 중 '만잘부'의 뜻으로 옳바른 것은?",
  "다음 중 '좋댓구알'의 뜻으로 옳바른 것은?",
  "다음 중 '반모'의 뜻으로 옳바른 것은?",
];

List<String> answerList1 = [
  "갓 : 이제 막",
  "캘리포니아에서 1박",
  "라면을 끓이고 있는 지원",
  "웃긴데 안 웃겨",
  "왜요? 제가 빌보드 핫백 1위 팬처럼 생겼나요?",
  "망치 매매법",
  "고양이가 소파를 다 뜯었다",
  "NCT",
  "호러",
  "팬이 되어 마음의 문이 열리는 소리",
  "앨범깡",
  "머선119",
  "이귀다",
  "저쩔티비",
  "무엇이든 줄여서 보여드립니다",
  "저녁 메뉴로 추천",
  "알아서 잘 딱 깔쌈하고 센스있게",
  "만나서 반갑고 잘 부탁해",
  "좋아요 댓글 구독 알림 설정",
  "반대 모양"
];
List<String> answerList2 = [
  "GOD : 신",
  "캘린더 박제",
  "먹방 유튜버를 보는 다희",
  "웃긴 줄 알았는데 안 웃겨",
  "왜요? 제가 복권 당첨된 사람처럼 생겼나요?",
  "상한가 매매법",
  "맛있게 만든 찌개를 밥상에 쏟았다",
  "에스파",
  "하이틴",
  "카세트 테이프를 되감을 때 내는 소리",
  "오프깡",
  "머선129",
  "삼귀다",
  "응쩔티비",
  "무엇이든 물어보세요",
  "저녁 메뉴 좀 추천",
  "알아서 잘 딱 깔끔하고 센스있게",
  "만나서 신나고 잘 부탁해",
  "좋구요 댓글 구독 알림 설정",
  "반지하 모집"
];
List<String> answerList3 = [
  "갓 : 머리에 쓰는 의관",
  "캘리그라피 박제",
  "배달 앱을 들락거리는 혜리",
  "웃어야 하는데 안 웃겨",
  "왜요? 제가 하하 엄마처럼 생겼나요?",
  "아이유 매매법",
  "강아지가 키우던 바질을 다 먹었다",
  "스테이씨",
  "액션",
  "분필로 점선을 그을 때 나는 소리",
  "셀프깡",
  "머선139",
  "사귀다",
  "어쩌티비",
  "무엇이든 물건을 보여드립니다",
  "저녁 메뉴 추천",
  "알아서 잘 딱 깔끔하고 센치하게",
  "만나서 반갑고 잘 부탁해",
  "좋아욧 댓글 구독 알림 설정",
  "반말 모드"
];

List<String> answer = [
  "GOD : 신",
  "캘린더 박제",
  "배달 앱을 들락거리는 혜리",
  "웃긴데 안 웃겨",
  "왜요? 제가 하하 엄마처럼 생겼나요?",
  "상한가 매매법",
  "강아지가 키우던 바질을 다 먹었다",
  "에스파",
  "하이틴",
  "카세트 테이프를 되감을 때 내는 소리",
  "셀프깡",
  "머선129",
  "삼귀다",
  "저쩔티비",
  "무엇이든 물어보세요",
  "저녁 메뉴 추천",
  "알아서 잘 딱 깔끔하고 센스있게",
  "만나서 반갑고 잘 부탁해",
  "좋아요 댓글 구독 알림 설정",
  "반말 모드",
];

class Quiz7 extends StatefulWidget {
  const Quiz7({Key? key}) : super(key: key);

  @override
  State<Quiz7> createState() => _Quiz7State();
}

class _Quiz7State extends State<Quiz7> {
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
              "신조어 퀴즈 (" + levelStr + ")",
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
  int number = prefs.getInt("QuizScore" + levelType + "6") ?? 0;
  if (score > number) {
    prefs.setInt("QuizScore" + levelType + "6", score);
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
