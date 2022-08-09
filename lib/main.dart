import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gosuoflife/home_page.dart';
import 'package:gosuoflife/market_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_service.dart';
import 'login_page.dart';
import 'miso.dart';
import 'onboard_page.dart';

late SharedPreferences prefs;

final supporteddLocales = [
  Locale('en', 'US'),
  Locale('ko', 'KR'),
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();

  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: supporteddLocales,
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isOnBoarded = prefs.getBool("isOnBoarded") ?? false;
    //final user = context.read<AuthService>().currentUser();
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          textTheme: GoogleFonts.getTextTheme('Jua'),
        ),
        debugShowCheckedModeBanner: false,
        home: ChangeNotifierProvider(
          create: (context) => AuthService(),
          child: MarketPage(),
          // child: isOnBoarded
          //     ? user == null
          //         ? LoginPage()
          //         : MarketPage()
          //     : OnboardingPage(),
        ));
  }
}
