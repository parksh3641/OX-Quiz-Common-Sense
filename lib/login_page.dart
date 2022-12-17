import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();

  bool ios = false;

  @override
  void initState() {
    super.initState();

    _assetsAudioPlayer.open(
      Audio("assets/audios/Background.mp3"),
      autoStart: true,
      showNotification: true,
    );
    _assetsAudioPlayer.play();

    if (Platform.isAndroid) ios = false;
    if (Platform.isIOS) ios = true;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("로그인"),
            automaticallyImplyLeading: false,
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
                    "퀴즈의 고수",
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
                              prefs.setString("LoginType", "Email");
                              // HomePage로 이동
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MarketPage()),
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
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.amber,
                        ),
                        icon: ImageIcon(AssetImage("images/Guest.png")),
                        label: Text(
                          "Sign ln with Guest",
                          style: TextStyle(fontSize: 21),
                        ),
                        onPressed: () async {
                          await authService.signInWithGuest();
                          final user = authService.currentUser();
                          if (user != null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("게스트 로그인 성공"),
                            ));
                            prefs.setString("LoginType", "Guest");
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MarketPage()),
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: (!ios) ? Colors.green : Colors.black,
                        ),
                        icon: (!ios)
                            ? ImageIcon(AssetImage("images/Google.png"))
                            : ImageIcon(AssetImage("images/Apple.png")),
                        label: (!ios)
                            ? Text(
                                "Sign ln with Google",
                                style: TextStyle(fontSize: 21),
                              )
                            : Text("Sign ln with Apple",
                                style: TextStyle(fontSize: 21)),
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
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MarketPage()),
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
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MarketPage()),
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
        );
      },
    );
  }
}
