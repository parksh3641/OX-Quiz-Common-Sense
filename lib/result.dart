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
              "최종 점수 : $score / 15",
              style: TextStyle(fontSize: 32),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "두뇌력 + 10",
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
                  minimumSize: const Size(100, 60),
                ),
                child: Text(
                  "메인화면",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MarketPage()),
                  );
                },
              ),
            ),
            // SizedBox(
            //   height: 20,
            // ),
            // Container(
            //   width: double.infinity,
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       primary: Colors.blue,
            //       minimumSize: const Size(100, 60),
            //     ),
            //     child: Text(
            //       "결과 공유",
            //       style: TextStyle(fontSize: 20),
            //     ),
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => MarketPage()),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
