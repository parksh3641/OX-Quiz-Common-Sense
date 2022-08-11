import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gosuoflife/auth_service.dart';
import 'package:gosuoflife/market_page.dart';
import 'package:gosuoflife/rank_service.dart';
import 'package:gosuoflife/result.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';
import 'main.dart';

class Quiz1 extends StatefulWidget {
  const Quiz1({Key? key}) : super(key: key);

  @override
  State<Quiz1> createState() => _Quiz1State();
}

int index = 0;
int score = 0;

List<String> dataList = [
  "블로장생을 꿈꿔 전 세계를 뒤져 불로초를 찾았던 왕의 이름은?",
  "평창동계올림픽이 열렸던 해는 몇년도인가요?"
];

List<String> answerList1 = ["진시황", "2018년"];
List<String> answerList2 = ["혜문왕", "2019년"];
List<String> answerList3 = ["효문왕", "2020년"];

List<String> answer = ["진시황", "2018년"];

class _Quiz1State extends State<Quiz1> {
  @override
  void initState() {
    super.initState();
    index = 0;
    score = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("상식 퀴즈"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              OpenDialog(context);
            },
            icon: Icon(Icons.clear),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Text(
              "현재 점수 : $score",
              style: TextStyle(color: Colors.black, fontSize: 26),
            ),
            Text(
              dataList[index],
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 26),
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (answerList1[index] == answer[index]) {
                      Success(context);
                    } else {
                      Failed(context);
                    }
                    Initialize(context);
                  });
                },
                child: Text(answerList1[index]),
              ),
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (answerList2[index] == answer[index]) {
                      Success(context);
                      score++;
                    } else {
                      Failed(context);
                    }

                    Initialize(context);
                  });
                },
                child: Text(answerList2[index]),
              ),
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (answerList3[index] == answer[index]) {
                      Success(context);
                    } else {
                      Failed(context);
                    }
                    Initialize(context);
                  });
                },
                child: Text(answerList3[index]),
              ),
            )
          ],
        ),
      ),
    );
  }

  void Initialize(BuildContext context) async {
    final user = context.read<AuthService>().currentUser()!;
    if (index + 1 > dataList.length - 1) {
      ScaffoldMessenger.of(context).clearSnackBars();
      int number = prefs.getInt("QuizeScore0") ?? 0;
      if (score > number) {
        prefs.setInt("QuizScore0", score);
        rankService.create(QuizType.Quiz1, score, user.uid);
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResultPage(score)),
      );
    } else {
      index++;
    }
  }
}

void Success(BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text("정답입니다!"),
  ));
  score++;
}

void Failed(BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text("오답입니다"),
  ));
}

void OpenDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: ((context) {
        return AlertDialog(
            title: Text("중단하기"),
            content: Text("퀴즈를 종료할까요?"),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MarketPage()),
                      );
                    },
                    child: Text(
                      "네",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "아니요",
                    ),
                  )
                ],
              ),
            ]);
      }));
}
