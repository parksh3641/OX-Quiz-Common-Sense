import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gosuoflife/main.dart';

int money = 0;

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  void initState() {
    super.initState();

    money = prefs.getInt("Money") ?? 0;
  }

  List<Map<String, dynamic>> dataList = [
    {
      "title": "추가 목숨 +1",
      "imgUrl": 'images/Heart.png',
    },
    {
      "title": "추가 시간 +10초",
      "imgUrl": 'images/Timer.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Text(
            "보유 코인 : " + money.toString(),
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: ListView.builder(
          itemCount: dataList.length,
          itemBuilder: (context, index) {
            final item = dataList[index % dataList.length];
            final title = item["title"] ?? "";
            final imgUrl = item["imgUrl"] ?? "";
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 21,
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 52,
                    // Tip : circleAvatar 배경에 맞춰서 동그랗게 이미지 넣는 방법
                    backgroundImage: AssetImage(imgUrl),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 21,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                        minimumSize: const Size(180, 50),
                      ),
                      child: Text(
                        "1000 코인",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        BuyProductDialog(context, title, index);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

void BuyProductDialog(BuildContext context, String title, int index) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: ((context) {
        return AlertDialog(
            title: Column(children: [
              Text(
                "구매 확인",
                style: TextStyle(fontSize: 26),
              ),
            ]),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(
                title,
                style: TextStyle(fontSize: 22),
              ),
            ]),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      money = prefs.getInt("Money") ?? 0;
                      if (money >= 1000) {
                        prefs.setInt("Money", money);

                        switch (index) {
                          case 0:
                            int heart = prefs.getInt("Heart") ?? 0;
                            if (heart + 1 > 10) {
                              MaxBuy(context);
                              return;
                            } else {
                              heart++;
                              prefs.setInt("Heart", heart);
                            }
                            break;
                          case 1:
                            int quizTime = prefs.getInt("QuizTime") ?? 0;
                            if (quizTime + 10 > 300) {
                              MaxBuy(context);
                              return;
                            } else {
                              quizTime += 10;
                              prefs.setInt("QuizTime", quizTime);
                            }
                            break;
                        }
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("구매 성공!"),
                        ));
                        Navigator.of(context).pop();
                      } else {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("코인이 부족합니다"),
                        ));
                      }
                    },
                    child: Text(
                      "1000 코인",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "취소",
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            ]);
      }));
}

void MaxBuy(BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text("더 이상 구매할 수 없습니다"),
  ));
}
