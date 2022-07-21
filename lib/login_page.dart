import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gosuoflife/auth_service.dart';
import 'package:provider/provider.dart';

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
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        return Scaffold(
          appBar: AppBar(title: Center(child: Text("로그인"))),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /// 현재 유저 로그인 상태
                Center(
                  child: Text(
                    "인생의 고수 : Just Do It",
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 175,
                      child: ElevatedButton(
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
                    ),

                    /// 회원가입 버튼
                    Container(
                      width: 175,
                      child: Container(
                        child: ElevatedButton(
                          child: Text("회원가입", style: TextStyle(fontSize: 21)),
                          onPressed: () {
                            // 회원가입
                            authService.signUp(
                              email: emailController.text,
                              password: passwordController.text,
                              onSuccess: () {
                                // 회원가입 성공
                                print("회원가입 성공");
                              },
                              onError: (err) {
                                // 에러 발생
                                print("회원가입 실패 : $err");
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        icon: ImageIcon(AssetImage("images/GoogleIcon.png")),
                        label: Text(
                          "구글 로그인",
                          style: TextStyle(fontSize: 21),
                        ),
                        onPressed: () {
                          print('sign ln with google');
                          authService.signInWithGoogle();
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
