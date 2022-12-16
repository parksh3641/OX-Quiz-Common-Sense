import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gosuoflife/auth_service.dart';
import 'package:gosuoflife/login_page.dart';
import 'package:gosuoflife/onboard_page.dart';
import 'package:gosuoflife/quiz1.dart';
import 'package:gosuoflife/quiz2.dart';
import 'package:gosuoflife/quiz3.dart';
import 'package:gosuoflife/quiz4.dart';
import 'package:gosuoflife/ranking_page.dart';
import 'package:gosuoflife/setting_page.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> dataList = [
      {
        "category": "상식 퀴즈",
        "imgUrl": "https://picsum.photos/200?image=10",
      },
      {
        "category": "사자성어 퀴즈",
        "imgUrl": "https://picsum.photos/250?image=20",
      },
      {
        "category": "나라 퀴즈",
        "imgUrl": "https://picsum.photos/250?image=30",
      },
      {
        "category": "OX 퀴즈",
        "imgUrl": "https://picsum.photos/250?image=40",
      },
    ];

    List<int> quizScore = [];

    for (int i = 0; i < dataList.length; i++) {
      quizScore.add(prefs.getInt("QuizScore$i") ?? 0);
    }

    return Consumer<AuthService>(
      builder: (context, authService, child) {
        final user = authService.currentUser()!;
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Center(
              child: Text(
                "홈",
              ),
            ),
            // actions: [
            //   IconButton(
            //     icon: Icon(Icons.restore),
            //     onPressed: () {
            //       prefs.clear();
            //       ScaffoldMessenger.of(context).clearSnackBars();
            //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //         content: Text("저장소 초기화 완료!"),
            //       ));
            //     },
            //   ),
            // ]
          ),
          body: Column(children: [
            Expanded(
                child: ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> data = dataList[index];
                String category = data["category"];
                String imgUrl = data["imgUrl"];

                return Card(
                  margin: const EdgeInsets.all(8),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          print("클릭 $index");
                          switch (index) {
                            case 0:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Quiz1()),
                              );
                              break;
                            case 1:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Quiz2()),
                              );
                              break;
                            case 2:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Quiz3()),
                              );
                              break;
                            case 3:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Quiz4()),
                              );
                              break;
                          }
                        },
                        child: Stack(
                          children: [
                            // 사진
                            Positioned.fill(
                              child: Image.network(
                                imgUrl,
                                width: double.infinity,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            // 좋아요
                            Container(
                                width: double.infinity,
                                height: 130,
                                color: Colors.black.withOpacity(0.5),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      category,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 36,
                                      ),
                                    ),
                                    Text(
                                      "최고 점수 : " + quizScore[index].toString(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 26),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ))
          ]),
          // drawer: Drawer(
          //   child: Column(children: [
          //     DrawerHeader(
          //       margin: EdgeInsets.all(0),
          //       decoration: BoxDecoration(color: Colors.amber),
          //       child: SizedBox(
          //         width: double.infinity,
          //         child: Column(
          //           children: [
          //             CircleAvatar(
          //               radius: 36,
          //               backgroundColor: Colors.white,
          //               child: Padding(
          //                 padding: EdgeInsets.all(8),
          //                 child: Image.asset("images/GoogleIcon.png"),
          //               ),
          //             ),
          //             SizedBox(
          //               height: 16,
          //             ),
          //             Text("${user.email}님 안녕하세요")
          //           ],
          //         ),
          //       ),
          //     )
          //   ]),
          // ),
        );
      },
    );
  }
}
