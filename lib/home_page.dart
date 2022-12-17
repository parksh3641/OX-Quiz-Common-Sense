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

String loginType = "";
String imagePath = "";

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    super.initState();
    loginType = prefs.getString("LoginType") ?? "Null";
    switch (loginType) {
      case "Email":
        imagePath = "images/Guest.png";
        break;
      case "Guest":
        imagePath = "images/Guest.png";
        break;
      case "Google":
        imagePath = "images/Google.png";
        break;
      case "Apple":
        imagePath = "images/Apple.png";
        break;
      case "Null":
        imagePath = "images/Guest.png";
        break;
    }
  }

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
        "category": "수도 퀴즈",
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
              //automaticallyImplyLeading: false,
              title: Center(
                child: Text(
                  "퀴즈 선택",
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.help),
                  onPressed: () {
                    //prefs.clear();
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("퀴즈를 선택하세요!"),
                    ));
                  },
                ),
              ]),
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
          drawer: Drawer(
            child: Column(children: [
              DrawerHeader(
                margin: EdgeInsets.all(0),
                decoration: BoxDecoration(color: Colors.amber),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 36,
                        backgroundColor: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Image.asset(imagePath),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      //Text("${user.email}님 안녕하세요")
                      Text(
                        "환영합니다",
                        style: TextStyle(fontSize: 26),
                      )
                    ],
                  ),
                ),
              ),
              // AspectRatio(
              //   aspectRatio: 12 / 4,
              //   child: PageView(
              //     children: [
              //       Image.network(
              //         "https://i.ibb.co/Q97cmkg/sale-event-banner1.jpg",
              //       ),
              //       Image.network(
              //         "https://i.ibb.co/GV78j68/sale-event-banner2.jpg",
              //       ),
              //       Image.network(
              //         "https://i.ibb.co/R3P3RHw/sale-event-banner3.jpg",
              //       ),
              //       Image.network(
              //         "https://i.ibb.co/LRb1VYs/sale-event-banner4.jpg",
              //       ),
              //     ],
              //   ),
              // ),
              ListTile(
                title: Text(
                  '내 정보',
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
                onTap: () {
                  // 클릭시 drawer 닫기
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  '설정',
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
                onTap: () {
                  // 클릭시 drawer 닫기
                  Navigator.pop(context);
                },
              ),
            ]),
          ),
        );
      },
    );
  }
}
