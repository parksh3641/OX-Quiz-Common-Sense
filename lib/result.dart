import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gosuoflife/home_page.dart';
import 'package:gosuoflife/market_page.dart';
import 'package:gosuoflife/quiz1.dart';

class ResultPage extends StatelessWidget {
  int score = 0;
  ResultPage(this.score, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("결과"),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "점수 : $score / 10",
              style: TextStyle(fontSize: 32),
            ),
            Text(
              "수고하셨습니다",
              style: TextStyle(fontSize: 26),
            ),
            Container(
              child: SizedBox(
                height: 100,
              ),
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  minimumSize: const Size(100, 80),
                ),
                child: Text(
                  "메인화면",
                  style: TextStyle(fontSize: 30),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MarketPage()),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
