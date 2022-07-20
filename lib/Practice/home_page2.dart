import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gosuoflife/main.dart';

class HomePage2 extends StatelessWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home Page!'),
        actions: [
          IconButton(
            onPressed: () {
              //prefs.clear();
            },
            icon: Icon(Icons.delete),
          )
        ],
      ),
      body: Center(
          child: Text(
        "환영합니다!",
        style: TextStyle(
          fontSize: 24,
        ),
      )),
    );
  }
}
