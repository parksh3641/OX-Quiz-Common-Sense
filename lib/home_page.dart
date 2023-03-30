import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gosuoflife/account.dart';
import 'package:gosuoflife/auth_service.dart';
import 'package:gosuoflife/login_page.dart';
import 'package:gosuoflife/market_page.dart';
import 'package:gosuoflife/onboard_page.dart';
import 'package:gosuoflife/quiz1.dart';
import 'package:gosuoflife/quiz2.dart';
import 'package:gosuoflife/quiz3.dart';
import 'package:gosuoflife/quiz4.dart';
import 'package:gosuoflife/quiz5.dart';
import 'package:gosuoflife/quiz6.dart';
import 'package:gosuoflife/quiz7.dart';
import 'package:gosuoflife/quiz8.dart';
import 'package:gosuoflife/ranking_page.dart';
import 'package:gosuoflife/setting_page.dart';
import 'package:provider/provider.dart';

import 'main.dart';

String loginType = "";
String imagePath = "";
String levelType = "";

late AssetsAudioPlayer _click = AssetsAudioPlayer.newPlayer();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    super.initState();
    loginType = prefs.getString("LoginType") ?? "Null";
    switch (loginType) {
      case "Email":
        imagePath = "images/Guest.png";
        break;
      case "Guest":
        imagePath = "images/Guest.png";
        break;
      case "Google":
        imagePath = "images/Google.png";
        break;
      case "Apple":
        imagePath = "images/Apple.png";
        break;
      case "Null":
        imagePath = "images/Guest.png";
        break;
    }

    _click.open(
      Audio("assets/audios/Click.wav"),
      loopMode: LoopMode.none,
      autoStart: false,
      showNotification: false,
    );
  }

  List<Map<String, dynamic>> dataList = [
    {
      "title": "상식 퀴즈",
      "imgUrl":
          "https://picsum.photos/200?image=" + Random().nextInt(300).toString(),
    },
    {
      "title": "사자성어 퀴즈",
      "imgUrl":
          "https://picsum.photos/200?image=" + Random().nextInt(300).toString(),
    },
    {
      "title": "수도 퀴즈",
      "imgUrl":
          "https://picsum.photos/200?image=" + Random().nextInt(300).toString(),
    },
    {
      "title": "OX 퀴즈",
      "imgUrl":
          "https://picsum.photos/200?image=" + Random().nextInt(300).toString(),
    },
    {
      "title": "초성 퀴즈 [영화]",
      "imgUrl":
          "https://picsum.photos/200?image=" + Random().nextInt(300).toString(),
    },
    {
      "title": "초성 퀴즈 [동물]",
      "imgUrl":
          "https://picsum.photos/200?image=" + Random().nextInt(300).toString(),
    },
    {
      "title": "신조어 퀴즈",
      "imgUrl":
          "https://picsum.photos/200?image=" + Random().nextInt(300).toString(),
    },
    // {
    //   "title": "MBTI 퀴즈",
    //   "imgUrl": "https://picsum.photos/200?image=" +
    //       Random().nextInt(300).toString(),
    // },
  ];

  @override
  Widget build(BuildContext context) {
    List<int> quizScoreEasy = [];
    List<int> quizScoreNormal = [];
    List<int> quizScoreHard = [];

    for (int i = 0; i < dataList.length; i++) {
      quizScoreEasy.add(prefs.getInt("QuizScoreEasy$i") ?? 0);
    }
    for (int i = 0; i < dataList.length; i++) {
      quizScoreNormal.add(prefs.getInt("QuizScoreNormal$i") ?? 0);
    }
    for (int i = 0; i < dataList.length; i++) {
      quizScoreHard.add(prefs.getInt("QuizScoreHard$i") ?? 0);
    }

    late DateTime lastPressedAt;

    return WillPopScope(
      onWillPop: () async {
        final now = DateTime.now();
        if (now.difference(lastPressedAt) > Duration(seconds: 2)) {
          lastPressedAt = now;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('뒤로 버튼을 한번 더 누르시면 종료됩니다'),
              duration: Duration(seconds: 2),
            ),
          );
          return false;
        }
        return true;
      },
      child: DefaultTabController(
        length: 3,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              elevation: 0,
              title: Transform(
                transform: Matrix4.translationValues(0, 0, 0),
                child: Text(
                  "퀴즈 선택",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.face, color: Colors.black),
                  onPressed: () {
                    _click.play();
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (BuildContext context,
                            Animation<double> animation1,
                            Animation<double> animation2) {
                          return AccountPage();
                        },
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  },
                ),
              ],

              /// Tip : AppBar 하단에 TabBar를 만들어 줍니다.
              bottom: TabBar(
                isScrollable: false,
                indicatorColor: Colors.blue,
                indicatorWeight: 4,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                labelStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                tabs: [
                  Tab(text: "쉬움"),
                  Tab(text: "보통"),
                  Tab(text: "어려움"),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                /// 전체 메뉴
                ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    final item = dataList[index % dataList.length];
                    final title = item["title"] ?? "";
                    final imgUrl = item["imgUrl"] ?? "";
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 21,
                      ),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 52,
                            // Tip : circleAvatar 배경에 맞춰서 동그랗게 이미지 넣는 방법
                            backgroundImage: NetworkImage(imgUrl),
                            backgroundColor: Colors.transparent,
                          ),
                          SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                title + " (쉬움)",
                                style: TextStyle(
                                  fontSize: 21,
                                  //fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                "최고 점수 : " + quizScoreEasy[index].toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: primaryColor,
                                minimumSize: const Size(180, 50),
                              ),
                              child: Text(
                                "문제 풀기",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                _click.play();
                                prefs.setString("LevelType", "Easy");
                                switch (index) {
                                  case 0:
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (BuildContext context,
                                            Animation<double> animation1,
                                            Animation<double> animation2) {
                                          return Quiz1();
                                        },
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration:
                                            Duration.zero,
                                      ),
                                    );
                                    break;
                                  case 1:
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (BuildContext context,
                                            Animation<double> animation1,
                                            Animation<double> animation2) {
                                          return Quiz2();
                                        },
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration:
                                            Duration.zero,
                                      ),
                                    );
                                    break;
                                  case 2:
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (BuildContext context,
                                            Animation<double> animation1,
                                            Animation<double> animation2) {
                                          return Quiz3();
                                        },
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration:
                                            Duration.zero,
                                      ),
                                    );
                                    break;
                                  case 3:
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (BuildContext context,
                                            Animation<double> animation1,
                                            Animation<double> animation2) {
                                          return Quiz4();
                                        },
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration:
                                            Duration.zero,
                                      ),
                                    );
                                    break;
                                  case 4:
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (BuildContext context,
                                            Animation<double> animation1,
                                            Animation<double> animation2) {
                                          return Quiz5();
                                        },
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration:
                                            Duration.zero,
                                      ),
                                    );
                                    break;
                                  case 5:
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (BuildContext context,
                                            Animation<double> animation1,
                                            Animation<double> animation2) {
                                          return Quiz6();
                                        },
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration:
                                            Duration.zero,
                                      ),
                                    );
                                    break;
                                  case 6:
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (BuildContext context,
                                            Animation<double> animation1,
                                            Animation<double> animation2) {
                                          return Quiz7();
                                        },
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration:
                                            Duration.zero,
                                      ),
                                    );
                                    break;
                                  case 7:
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (BuildContext context,
                                            Animation<double> animation1,
                                            Animation<double> animation2) {
                                          return Quiz8();
                                        },
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration:
                                            Duration.zero,
                                      ),
                                    );
                                    break;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    final item = dataList[index % dataList.length];
                    final title = item["title"] ?? "";
                    final imgUrl = item["imgUrl"] ?? "";
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 21,
                      ),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 52,
                            // Tip : circleAvatar 배경에 맞춰서 동그랗게 이미지 넣는 방법
                            backgroundImage: NetworkImage(imgUrl),
                            backgroundColor: Colors.transparent,
                          ),
                          SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                title + " (보통)",
                                style: TextStyle(
                                  fontSize: 21,
                                  //fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                "최고 점수 : " + quizScoreNormal[index].toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: primaryColor,
                                minimumSize: const Size(180, 50),
                              ),
                              child: Text(
                                "문제 풀기",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                _click.play();
                                prefs.setString("LevelType", "Normal");
                                switch (index) {
                                  case 0:
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (BuildContext context,
                                            Animation<double> animation1,
                                            Animation<double> animation2) {
                                          return Quiz1();
                                        },
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration:
                                            Duration.zero,
                                      ),
                                    );
                                    break;
                                  case 1:
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (BuildContext context,
                                            Animation<double> animation1,
                                            Animation<double> animation2) {
                                          return Quiz2();
                                        },
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration:
                                            Duration.zero,
                                      ),
                                    );
                                    break;
                                  case 2:
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (BuildContext context,
                                            Animation<double> animation1,
                                            Animation<double> animation2) {
                                          return Quiz3();
                                        },
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration:
                                            Duration.zero,
                                      ),
                                    );
                                    break;
                                  case 3:
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (BuildContext context,
                                            Animation<double> animation1,
                                            Animation<double> animation2) {
                                          return Quiz4();
                                        },
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration:
                                            Duration.zero,
                                      ),
                                    );
                                    break;
                                  case 4:
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (BuildContext context,
                                            Animation<double> animation1,
                                            Animation<double> animation2) {
                                          return Quiz5();
                                        },
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration:
                                            Duration.zero,
                                      ),
                                    );
                                    break;
                                  case 5:
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (BuildContext context,
                                            Animation<double> animation1,
                                            Animation<double> animation2) {
                                          return Quiz6();
                                        },
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration:
                                            Duration.zero,
                                      ),
                                    );
                                    break;
                                  case 6:
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (BuildContext context,
                                            Animation<double> animation1,
                                            Animation<double> animation2) {
                                          return Quiz7();
                                        },
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration:
                                            Duration.zero,
                                      ),
                                    );
                                    break;
                                  case 7:
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (BuildContext context,
                                            Animation<double> animation1,
                                            Animation<double> animation2) {
                                          return Quiz8();
                                        },
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration:
                                            Duration.zero,
                                      ),
                                    );
                                    break;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    final item = dataList[index % dataList.length];
                    final title = item["title"] ?? "";
                    final imgUrl = item["imgUrl"] ?? "";
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 21,
                      ),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 52,
                            // Tip : circleAvatar 배경에 맞춰서 동그랗게 이미지 넣는 방법
                            backgroundImage: NetworkImage(imgUrl),
                            backgroundColor: Colors.transparent,
                          ),
                          SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                title + " (어려움)",
                                style: TextStyle(
                                  fontSize: 21,
                                  //fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                "최고 점수 : " + quizScoreHard[index].toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: primaryColor,
                                minimumSize: const Size(180, 50),
                              ),
                              child: Text(
                                "문제 풀기",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                _click.play();
                                prefs.setString("LevelType", "Hard");
                                switch (index) {
                                  case 0:
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (BuildContext context,
                                            Animation<double> animation1,
                                            Animation<double> animation2) {
                                          return Quiz1();
                                        },
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration:
                                            Duration.zero,
                                      ),
                                    );
                                    break;
                                  case 1:
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (BuildContext context,
                                            Animation<double> animation1,
                                            Animation<double> animation2) {
                                          return Quiz2();
                                        },
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration:
                                            Duration.zero,
                                      ),
                                    );
                                    break;
                                  case 2:
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (BuildContext context,
                                            Animation<double> animation1,
                                            Animation<double> animation2) {
                                          return Quiz3();
                                        },
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration:
                                            Duration.zero,
                                      ),
                                    );
                                    break;
                                  case 3:
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (BuildContext context,
                                            Animation<double> animation1,
                                            Animation<double> animation2) {
                                          return Quiz4();
                                        },
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration:
                                            Duration.zero,
                                      ),
                                    );
                                    break;
                                  case 4:
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (BuildContext context,
                                            Animation<double> animation1,
                                            Animation<double> animation2) {
                                          return Quiz5();
                                        },
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration:
                                            Duration.zero,
                                      ),
                                    );
                                    break;
                                  case 5:
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (BuildContext context,
                                            Animation<double> animation1,
                                            Animation<double> animation2) {
                                          return Quiz6();
                                        },
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration:
                                            Duration.zero,
                                      ),
                                    );
                                    break;
                                  case 6:
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (BuildContext context,
                                            Animation<double> animation1,
                                            Animation<double> animation2) {
                                          return Quiz7();
                                        },
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration:
                                            Duration.zero,
                                      ),
                                    );
                                    break;
                                  case 7:
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (BuildContext context,
                                            Animation<double> animation1,
                                            Animation<double> animation2) {
                                          return Quiz8();
                                        },
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration:
                                            Duration.zero,
                                      ),
                                    );
                                    break;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
