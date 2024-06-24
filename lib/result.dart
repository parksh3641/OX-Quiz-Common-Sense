import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gosuoflife/home_page.dart';
import 'package:gosuoflife/main.dart';
import 'package:gosuoflife/market_page.dart';
import 'package:gosuoflife/quiz1.dart';

int money = 0;
int score = 0;

String shareText = "";
String urlText = "";

AdManagerInterstitialAd? _interstitialAd;

class ResultPage extends StatefulWidget {
  ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  Future<void> share() async {
    await FlutterShare.share(
        title: "OX 퀴즈 : 상식 문제를 다운받으세요!",
        text: shareText,
        linkUrl: urlText,
        chooserTitle: 'OX 퀴즈 : 상식 문제 공유하기');
  }

  @override
  void initState() {
    super.initState();

    score = prefs.getInt("Score") ?? 0;

    money = prefs.getInt("Money") ?? 0;
    money += (10 * score);
    prefs.setInt("Money", money);

    if (Platform.isAndroid) {
      urlText =
          "https://play.google.com/store/apps/details?id=com.flutter.gosuoflife";
    } else {
      urlText =
          "https://apps.apple.com/kr/app/ox-%ED%80%B4%EC%A6%88-%EC%9D%BC%EB%B0%98-%EC%83%81%EC%8B%9D/id1660371017";
    }

    loadAd();
  }

  void loadAd() {
    AdManagerInterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-6754544778509872/5259001239'
            : 'ca-app-pub-6754544778509872/5472707939',
        request: const AdManagerAdRequest(),
        adLoadCallback: AdManagerInterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            _interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('AdManagerInterstitialAd failed to load: $error');
          },
        ));
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
                    "최고 점수 : $score/15",
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
                      //_interstitialAd?.show();
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
                      shareText = "최고 점수 : $score/15 점을 달성했어요!";
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
