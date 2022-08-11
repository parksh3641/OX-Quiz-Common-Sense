import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gosuoflife/home_page.dart';
import 'package:gosuoflife/market_page.dart';
import 'package:gosuoflife/rank_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_service.dart';
import 'login_page.dart';
import 'onboard_page.dart';

late SharedPreferences prefs;
late RankService rankService;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();

  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => RankService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isOnBoarded = prefs.getBool("isOnBoarded") ?? false;
    final user = context.read<AuthService>().currentUser();
    rankService = context.read<RankService>();
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: Colors.blue,
        textTheme: GoogleFonts.getTextTheme('Jua'),
      ),
      debugShowCheckedModeBanner: false,
      home: isOnBoarded
          ? user == null
              ? LoginPage()
              : MarketPage()
          : OnboardingPage(),
    );
  }
}
