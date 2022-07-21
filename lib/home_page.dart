import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gosuoflife/auth_service.dart';
import 'package:gosuoflife/login_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        final user = authService.currentUser()!;
        return Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                "메뉴 선택",
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  authService.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              )
            ],
          ),
          body: Center(child: Text("목록 준비중입니다")),
          drawer: Drawer(
            child: Column(children: [
              DrawerHeader(
                margin: EdgeInsets.all(0),
                decoration: BoxDecoration(color: Colors.amber),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 36,
                        backgroundColor: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Image.asset("images/GoogleIcon.png"),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text("${user.email}님 안녕하세요")
                    ],
                  ),
                ),
              )
            ]),
          ),
        );
      },
    );
  }
}
