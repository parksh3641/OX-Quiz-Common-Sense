import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gosuoflife/auth_service.dart';
import 'package:gosuoflife/onboard_page.dart';
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
          appBar: AppBar(
            title: Text("로그인"),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.help),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => OnboardingPage()),
                );
              },
            ),
          ),
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
// 로그인
                          authService.signIn(
                            email: emailController.text,
                            password: passwordController.text,
                            onSuccess: () {
                              // 로그인 성공
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("로그인 성공"),
                              ));

                              // HomePage로 이동
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                              );
                            },
                            onError: (err) {
                              // 에러 발생
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(err),
                              ));
                            },
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
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("회원가입 성공"),
                                ));
                              },
                              onError: (err) {
                                // 에러 발생
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(err),
                                ));
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
                        onPressed: () async {
                          await authService.signInWithGoogle();
                          final user = authService.currentUser();
                          if (user != null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("구글 로그인 성공"),
                            ));
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                            );
                          }
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
