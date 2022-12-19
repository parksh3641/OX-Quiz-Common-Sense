import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gosuoflife/main.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> dataList = [
      {
        "title": "상식 퀴즈 구매",
        "price": "코인 1000",
      },
      {
        "title": "광고 제거",
        "price": "코인 1500",
      },
      {
        "title": "광고 제거",
        "price": "코인 2000",
      },
      {
        "title": "광고 제거",
        "price": "코인 2500",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("상점"),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(children: [
          Expanded(
              child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              Map<String, dynamic> data = dataList[index];
              String title = data["title"];
              String price = data["price"];

              return Card(
                margin: const EdgeInsets.all(8),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print("클릭 $index");
                      },
                      child: Stack(
                        children: [
                          ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                  minimumSize:
                                      const Size(double.infinity, 100)),
                              onPressed: () {},
                              icon: Icon(
                                Icons.lock_open,
                                size: 60,
                              ),
                              label: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      title,
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    Text(
                                      price,
                                      style: TextStyle(fontSize: 20),
                                    )
                                  ])),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ))
        ]),
      ),
    );
  }
}
