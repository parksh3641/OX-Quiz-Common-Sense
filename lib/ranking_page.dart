import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gosuoflife/main.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({Key? key}) : super(key: key);

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class RankContent {
  String id = "";
  int score = 0;

  RankContent(this.id, this.score);
}

List<RankContent> rankContentList = [
  // RankContent("Parker", 20),
  // RankContent("Petter", 10),
];

class _RankingPageState extends State<RankingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Text(
            "랭킹",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Center(
            child: Text(
          "준비중입니다",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
