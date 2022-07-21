import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gosuoflife/home_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_service.dart';
import 'login_page.dart';
import 'miso.dart';
import 'onboard_page.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();

  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
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
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.getTextTheme('Jua'),
      ),
      debugShowCheckedModeBanner: false,
      home: Miso(),
      // home: isOnBoarded
      //     ? user == null
      //         ? LoginPage()
      //         : HomePage()
      //     : OnboardingPage(),
    );
  }
}
