import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gosuoflife/auth_service.dart';
import 'package:gosuoflife/market_page.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import 'login_page.dart';
import 'main.dart';

late bool vibration = prefs.getBool(("Vibration")) ?? true;

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String versionInfo = "";

  @override
  void initState() {
    super.initState();

    getVersionInfo();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   elevation: 0,
        //   centerTitle: true,
        //   automaticallyImplyLeading: false,
        //   backgroundColor: Colors.white,
        //   title: Transform(
        //     transform: Matrix4.translationValues(0, 0, 0),
        //     child: Text(
        //       "설정",
        //       style: TextStyle(color: Colors.black),
        //     ),
        //   ),
        // ),
        body: SettingsList(
          sections: [
            SettingsSection(
              title: Text(
                '공통',
              ),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  leading: Icon(Icons.language),
                  title: Text('언어'),
                  value: Text('한국어'),
                  onPressed: ((context) {
                    OpenLanguageDialog(context);
                  }),
                ),
                SettingsTile.switchTile(
                  title: Text('진동'),
                  initialValue: vibration,
                  onToggle: (value) {
                    setState(() {
                      vibration = !vibration;
                    });
                    prefs.setBool("Vibration", vibration);
                  },
                  leading: Icon(Icons.vibration),
                ),
                // SettingsTile.switchTile(
                //   title: Text('다크 모드'),
                //   initialValue: darkMode,
                //   onToggle: (value) {
                //     setState(() {
                //       darkMode = !darkMode;
                //     });
                //     prefs.setBool("DarkMode", darkMode);
                //   },
                //   leading: Icon(Icons.dark_mode),
                // ),
              ],
            ),
            SettingsSection(
              title: Text('계정'),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  leading: Icon(Icons.logout),
                  title: Text('로그아웃'),
                  onPressed: ((context) {
                    try {
                      if (Platform.isAndroid || Platform.isIOS) {
                        OpenLogOutDialog(context);
                      } else {}
                    } catch (e) {}
                  }),
                ),
                SettingsTile.navigation(
                  leading: Icon(Icons.person_off),
                  title: Text('계정 탈퇴'),
                  onPressed: ((context) {
                    try {
                      if (Platform.isAndroid || Platform.isIOS) {
                        OpenDelectAccountDialog(context);
                      } else {}
                    } catch (e) {}
                  }),
                )
              ],
            ),
            SettingsSection(
              title: Text('기타'),
              tiles: <SettingsTile>[
                // SettingsTile.navigation(
                //   leading: Icon(Icons.star),
                //   title: Text('앱 평가하기'),
                //   onPressed: ((context) {
                //     try {
                //       if (Platform.isIOS) {
                //         launchUrl(
                //           Uri.parse(
                //               'https://apps.apple.com/kr/app/%ED%80%B4%EC%A6%88%EC%9D%98-%EA%B3%A0%EC%88%98/id1660371017'),
                //         );
                //       } else {
                //         launchUrl(
                //           Uri.parse(
                //               'https://play.google.com/store/apps/details?id=com.flutter.gosuoflife&hl=ko&gl=US'),
                //         );
                //       }
                //     } catch (e) {}
                //   }),
                // ),
                SettingsTile.navigation(
                  leading: Icon(Icons.account_circle),
                  title: Text('개인정보처리방침'),
                  onPressed: ((context) {
                    launchUrl(
                      Uri.parse(
                          'https://sites.google.com/view/spnkprivacy/%ED%99%88'),
                    );
                  }),
                ),
                SettingsTile.navigation(
                  leading: Icon(Icons.system_update),
                  title: Text('앱 버전'),
                  value: Text(versionInfo),
                  onPressed: ((context) {}),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getVersionInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      versionInfo = packageInfo.version;
    });
  }
}

void OpenLogOutDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: ((context) {
        return AlertDialog(
            title: Column(children: [
              Text(
                "로그아웃",
                style: TextStyle(fontSize: 26),
              ),
            ]),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(
                "로그아웃 하시겠습니까?",
                style: TextStyle(fontSize: 22),
              ),
            ]),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthService>().signOut();
                      prefs.setString("LoginType", "Null");
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (BuildContext context,
                              Animation<double> animation1,
                              Animation<double> animation2) {
                            return LoginPage();
                          },
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                    child: Text(
                      "네",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "아니요",
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            ]);
      }));
}

void OpenDelectAccountDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: ((context) {
        return AlertDialog(
            title: Column(children: [
              Text(
                "계정 탈퇴",
                style: TextStyle(fontSize: 26),
              ),
            ]),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(
                "계정을 탈퇴하시겠습니까?",
                style: TextStyle(fontSize: 22),
              ),
            ]),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthService>().signOut();
                      prefs.setString("LoginType", "Null");
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (BuildContext context,
                              Animation<double> animation1,
                              Animation<double> animation2) {
                            return LoginPage();
                          },
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                    child: Text("네", style: TextStyle(fontSize: 20)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("아니요", style: TextStyle(fontSize: 20)),
                  )
                ],
              ),
            ]);
      }));
}

void OpenLanguageDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
            title: Column(children: [
              Text(
                "언어 선택",
                style: TextStyle(fontSize: 26),
              ),
            ]),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(
                "언어를 선택해주세요",
                style: TextStyle(fontSize: 22),
              ),
            ]),
            actions: <Widget>[
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(400, 60),
                      ),
                      onPressed: () {
                        SetSnackBar(context, "한국어로 변경됨");
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "한국어",
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                  ),
                  // Container(
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       SetSnackBar(context, "영어로 변경됨");
                  //       Navigator.of(context).pop();
                  //     },
                  //     child: Text("English"),
                  //   ),
                  // ),
                ],
              ),
            ]);
      });
}

void SetSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
  ));
}
