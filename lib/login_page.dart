import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gosuoflife/auth_service.dart';
import 'package:gosuoflife/market_page.dart';
import 'package:gosuoflife/onboard_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';
import 'main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool ios = false;

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) ios = false;
    if (Platform.isIOS) ios = true;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: Transform(
                transform: Matrix4.translationValues(0, 0, 0),
                child: Text(
                  "OX 퀴즈 : 일반 상식 로그인",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            body: WillPopScope(
              onWillPop: () {
                setState(() {});
                return Future(() => false);
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                        child: Image(
                      height: 150,
                      image: AssetImage('images/MainIcon.jpg'),
                    )),
                    SizedBox(height: 20),

                    /// 이메일
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(labelText: "이메일"),
                    ),

                    /// 비밀번호
                    TextField(
                      controller: passwordController,
                      obscureText: true, // 비밀번호 안보이게
                      decoration: InputDecoration(labelText: "비밀번호"),
                    ),
                    SizedBox(height: 32),

                    /// 로그인 버튼
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 170,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: primaryColor,
                            ),
                            child: Text(
                              "로그인",
                              style: TextStyle(
                                  fontSize: 21,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
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
                                  prefs.setString("LoginType", "Email");
                                  // HomePage로 이동
                                  Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (BuildContext context,
                                          Animation<double> animation1,
                                          Animation<double> animation2) {
                                        return MarketPage();
                                      },
                                      transitionDuration: Duration.zero,
                                      reverseTransitionDuration: Duration.zero,
                                    ),
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
                          width: 170,
                          height: 50,
                          child: Container(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: primaryColor,
                              ),
                              child: Text("회원가입",
                                  style: TextStyle(
                                      fontSize: 21,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
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
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: primaryColor,
                            ),
                            child: Text(
                              "게스트 입장",
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async {
                              await authService.signInWithGuest();
                              final user = authService.currentUser();
                              if (user != null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("게스트 로그인 성공"),
                                ));
                                prefs.setString("LoginType", "Guest");
                                // ignore: use_build_context_synchronously
                                Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (BuildContext context,
                                        Animation<double> animation1,
                                        Animation<double> animation2) {
                                      return MarketPage();
                                    },
                                    transitionDuration: Duration.zero,
                                    reverseTransitionDuration: Duration.zero,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              primary: (!ios) ? primaryColor : Colors.black,
                            ),
                            icon: (!ios)
                                ? ImageIcon(
                                    AssetImage("images/Google.png"),
                                    color: Colors.white,
                                  )
                                : ImageIcon(
                                    AssetImage("images/Apple.png"),
                                    color: Colors.white,
                                  ),
                            label: (!ios)
                                ? Text(
                                    "구글 로그인",
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text("Sign ln with Apple",
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                            onPressed: () async {
                              if (!ios) {
                                await authService.signInWithGoogle();
                                final user = authService.currentUser();
                                if (user != null) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("구글 로그인 성공"),
                                  ));
                                  prefs.setString("LoginType", "Google");
                                  // ignore: use_build_context_synchronously
                                  Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (BuildContext context,
                                          Animation<double> animation1,
                                          Animation<double> animation2) {
                                        return MarketPage();
                                      },
                                      transitionDuration: Duration.zero,
                                      reverseTransitionDuration: Duration.zero,
                                    ),
                                  );
                                }
                              } else {
                                await authService.signInWithApple();
                                final user = authService.currentUser();
                                if (user != null) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("애플 로그인 성공"),
                                  ));
                                  prefs.setString("LoginType", "Apple");
                                  // ignore: use_build_context_synchronously
                                  Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (BuildContext context,
                                          Animation<double> animation1,
                                          Animation<double> animation2) {
                                        return MarketPage();
                                      },
                                      transitionDuration: Duration.zero,
                                      reverseTransitionDuration: Duration.zero,
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
