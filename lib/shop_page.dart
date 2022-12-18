import 'package:flutter/material.dart';
import 'package:gosuoflife/main.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> dataList = [
      {
        "title": "광고 제거",
        "price": "1 USD",
      },
      {
        "title": "광고 제거",
        "price": "1 USD",
      },
      {
        "title": "광고 제거",
        "price": "1 USD",
      },
      {
        "title": "광고 제거",
        "price": "1 USD",
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
            itemCount: 1,
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
                                  primary: Colors.green,
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
