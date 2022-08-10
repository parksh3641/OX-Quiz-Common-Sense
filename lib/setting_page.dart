import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gosuoflife/auth_service.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("설정"),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  child: Text(
                    "언어 선택",
                    style: TextStyle(fontSize: 22),
                  ),
                  onPressed: () {
                    OpenLanguageDialog(context);
                  },
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  child: Text(
                    "로그아웃",
                    style: TextStyle(fontSize: 22),
                  ),
                  onPressed: () {
                    OpenLogOutDialog(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void OpenLogOutDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: ((context) {
        return AlertDialog(
            title: Text("로그아웃"),
            content: Text("정말 로그아웃 하실 건가요?"),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthService>().signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      "네",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "아니요",
                    ),
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
            title: Text("언어 선택"),
            content: Text("언어를 선택해주세요"),
            actions: <Widget>[
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        SetSnackBar(context, "한국어로 변경됨");
                        Navigator.of(context).pop();
                      },
                      child: Text("한국어"),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        SetSnackBar(context, "Change to English");
                        Navigator.of(context).pop();
                      },
                      child: Text("English"),
                    ),
                  ),
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
