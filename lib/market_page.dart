import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gosuoflife/main.dart';
import 'package:gosuoflife/ranking_page.dart';
import 'package:gosuoflife/setting_page.dart';
import 'package:gosuoflife/shop_page.dart';

import 'home_page.dart';

late AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();

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
    ShopPage(),
    SettingPage()
  ];

  void ChangePage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void initState() {
    super.initState();
    _assetsAudioPlayer.open(
      Audio("assets/audios/Background.mp3"),
      loopMode: LoopMode.single,
      autoStart: false,
      showNotification: false,
    );

    music = prefs.getBool("Music") ?? true;

    if (music) {
      _assetsAudioPlayer.play();
    } else {
      _assetsAudioPlayer.stop();
    }
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
              icon: Icon(Icons.shop),
              label: "상점",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "설정",
            ),
          ],
          currentIndex: selectedIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.lightGreen,
          backgroundColor: Colors.white,
          onTap: ChangePage,
        ),
      ),
    );
  }
}

void StopMusic() {
  _assetsAudioPlayer.pause();
}

void PlayMusic() {
  _assetsAudioPlayer.play();
}
