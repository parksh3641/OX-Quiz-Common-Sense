import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("인생의 고수 : Do It"))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              "images/Background.png",
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),

            /// 현재 유저 로그인 상태
            Center(
              child: Text(
                "로그인해 주세요 🙂",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            SizedBox(height: 32),

            /// 이메일
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "이메일"),
            ),

            /// 비밀번호
            TextField(
              controller: passwordController,
              obscureText: false, // 비밀번호 안보이게
              decoration: InputDecoration(labelText: "비밀번호"),
            ),
            SizedBox(height: 32),

            /// 로그인 버튼
            Row(
              children: [
                ElevatedButton(
                  child: Text(
                    "로그인",
                    style: TextStyle(fontSize: 21),
                  ),
                  onPressed: () {
                    // 로그인 성공시 HomePage로 이동
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => HomePage()),
                    );
                  },
                ),

                /// 회원가입 버튼
                ElevatedButton(
                  child: Text("회원가입", style: TextStyle(fontSize: 21)),
                  onPressed: () {
                    // 회원가입
                    print("sign up");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
