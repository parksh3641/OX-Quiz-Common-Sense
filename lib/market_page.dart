import 'package:flutter/material.dart';
import 'package:gosuoflife/main.dart';
import 'package:gosuoflife/setting_page.dart';
import 'package:gosuoflife/shop_page.dart';
import 'package:gosuoflife/stopwatch.dart';
import 'package:gosuoflife/todolist.dart';

import 'home_page.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: IndexedStack(
          index: currentIndex, // index 순서에 해당하는 child를 맨 위에 보여줌
          children: [
            HomePage(),
            ShopPage(),
            StopWatchPage(),
            //ToDoListPage(),
            SettingPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (newIndex) {
            setState(() {
              currentIndex = newIndex;
            });
          },
          selectedItemColor: primaryColor, // 선택된 아이콘 색상
          unselectedItemColor: Colors.grey, // 선택되지 않은 아이콘 색상
          showSelectedLabels: true, // 선택된 항목 label 숨기기
          showUnselectedLabels: true, // 선택되지 않은 항목 label 숨기기
          type: BottomNavigationBarType.fixed, // 선택시 아이콘 움직이지 않기
          backgroundColor: Colors.white.withOpacity(0.8),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "홈",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              label: "상점",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timer),
              label: "스톱워치",
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.list),
            //   label: "할일",
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "설정",
            ),
          ],
        ),
      ),
    );
  }
}
