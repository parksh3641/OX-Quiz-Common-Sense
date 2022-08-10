import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gosuoflife/home_page.dart';
import 'package:gosuoflife/market_page.dart';
import 'package:gosuoflife/quiz1.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key}) : super(key: key);

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
            Text(
              "점수 : $score",
              style: TextStyle(fontSize: 32),
            ),
            Container(
              child: SizedBox(
                height: 100,
              ),
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                child: Text("메인화면"),
                onPressed: () {
                  Navigator.pushReplacement(
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
