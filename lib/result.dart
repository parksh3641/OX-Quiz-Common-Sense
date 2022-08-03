import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gosuoflife/home_page.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("결과"),
      ),
      body: Column(children: [
        Text(
          "점수 : 999",
          style: TextStyle(fontSize: 32),
        ),
        Container(
          width: double.infinity,
          child: ElevatedButton(
            child: Text("메인화면"),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
        )
      ]),
    );
  }
}
