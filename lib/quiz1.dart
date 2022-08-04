import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gosuoflife/result.dart';

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
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
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
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("정답입니다!"),
                      ));
                      score++;
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("오답입니다"),
                      ));
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
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("정답입니다!"),
                      ));
                      score++;
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("오답입니다"),
                      ));
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
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("정답입니다!"),
                      ));
                      score++;
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("오답입니다"),
                      ));
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
    if (index + 1 > dataList.length - 1) {
      score = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResultPage()),
      );
      int number = prefs.getInt("QuizeScore0") ?? 0;
      if (score > number) {
        prefs.setInt("QuizScore0", score);
      }
    } else {
      index++;
    }
  }
}
