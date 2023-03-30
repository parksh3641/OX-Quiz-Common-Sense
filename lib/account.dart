import 'package:flutter/material.dart';

import 'main.dart';
import 'market_page.dart';

int number = 0;

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    number = 0;
    for (int i = 0; i < 8; i++) {
      number += prefs.getInt("QuizScoreEasy$i") ?? 0;
      number += prefs.getInt("QuizScoreNormal$i") ?? 0;
      number += prefs.getInt("QuizScoreHard$i") ?? 0;
    }
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Transform(
            transform: Matrix4.translationValues(0, 0, 0),
            child: Text(
              "프로필",
              style: TextStyle(color: Colors.black),
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
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
        body: Column(children: [
          DrawerHeader(
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.black,
                    child: Padding(
                      padding: EdgeInsets.all(2),
                      child: Image.asset('images/Guest.png'),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "최고 점수 총합 : " + number.toString(),
                    style: TextStyle(fontSize: 22),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
