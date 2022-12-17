import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gosuoflife/login_page.dart';
import 'package:gosuoflife/main.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
// 첫 번째 페이지
          PageViewModel(
            title: "다양한 퀴즈",
            body: "다양한 퀴즈를 풀면서 새로운 지식을 습득할 수 있습니다",
            image: Image(
              width: 200,
              image: AssetImage('images/MainIcon.jpg'),
            ),
            decoration: PageDecoration(
              titleTextStyle: TextStyle(
                color: Colors.blueAccent,
                fontSize: 36,
              ),
              bodyTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 26,
              ),
            ),
          ),
          // 두 번째 페이지
          PageViewModel(
            title: "사람들과 경쟁",
            body: "다른 사람들과 퀴즈 점수를 경쟁할 수 있습니다",
            image: Image(
              width: 200,
              image: AssetImage('images/MainIcon.jpg'),
            ),
            decoration: PageDecoration(
              titleTextStyle: TextStyle(
                color: Colors.blueAccent,
                fontSize: 36,
              ),
              bodyTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 26,
              ),
            ),
          ),
        ],
        next: Text("다음", style: TextStyle(fontSize: 26)),
        done: Text("완료", style: TextStyle(fontSize: 26)),
        onDone: () {
          prefs.setBool("isOnBoarded", true);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        },
      ),
    );
  }
}
