import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gosuoflife/login_page.dart';
import 'package:provider/provider.dart';

import 'auth_service.dart';
import 'market_page.dart';

bool isLogin = false;

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 1500), () {
      if (isLogin) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MarketPage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthService>().currentUser();
    if (user == null) {
      isLogin = false;
    } else {
      isLogin = true;
    }
    return WillPopScope(
      onWillPop: () async => false,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    child: Image(
                  height: 200,
                  image: AssetImage('images/MainIcon.jpg'),
                )),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Text("퀴즈의 고수",
                      style: TextStyle(fontSize: 36, color: Colors.black)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
