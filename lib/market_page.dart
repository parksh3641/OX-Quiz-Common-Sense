import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gosuoflife/ranking_page.dart';
import 'package:gosuoflife/setting_page.dart';

import 'home_page.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  int selectedIndex = 0;

  final List<Widget> widgetOptions = <Widget>[
    HomePage(),
    RankingPage(),
    SettingPage()
  ];

  void ChangePage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(child: widgetOptions.elementAt(selectedIndex)),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "홈",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: "랭킹",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "설정",
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.lightGreen,
          onTap: ChangePage,
        ),
      ),
    );
  }
}
