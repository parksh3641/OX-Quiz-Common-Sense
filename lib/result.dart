import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:gosuoflife/home_page.dart';
import 'package:gosuoflife/main.dart';
import 'package:gosuoflife/market_page.dart';
import 'package:gosuoflife/quiz1.dart';

int money = 0;
int score = 0;

String shareText = "";

class ResultPage extends StatefulWidget {
  ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  Future<void> share() async {
    await FlutterShare.share(
        title: "퀴즈의 고수를 다운 받으세요!",
        text: shareText,
        linkUrl:
            'https://play.google.com/store/apps/details?id=com.flutter.gosuoflife&hl=ko&gl=US',
        chooserTitle: '퀴즈의 고수 공유하기');
  }

  @override
  void initState() {
    super.initState();

    score = prefs.getInt("Score") ?? 0;

    money = prefs.getInt("Money") ?? 0;
    money += (10 * score);
    prefs.setInt("Money", money);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("결과"),
            automaticallyImplyLeading: false,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  child: Text(
                    "최종 점수 : $score / 15",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "코인 획득 +" + (10 * score).toString(),
                  style: TextStyle(fontSize: 22),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "수고하셨습니다",
                  style: TextStyle(fontSize: 22),
                ),
                Container(
                  child: SizedBox(
                    height: 60,
                  ),
                ),
                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      minimumSize: const Size(400, 60),
                    ),
                    child: Text(
                      "메인화면",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (BuildContext context,
                              Animation<double> animation1,
                              Animation<double> animation2) {
                            return MarketPage();
                          },
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  child: SizedBox(
                    height: 30,
                  ),
                ),
                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      minimumSize: const Size(400, 60),
                    ),
                    child: Text(
                      "결과 공유하기",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      shareText = "최종 점수 : $score / 15 를 달성했어요!";
                      share();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
