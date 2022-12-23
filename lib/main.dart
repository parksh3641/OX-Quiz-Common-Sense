import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gosuoflife/color_schemes.g.dart';
import 'package:gosuoflife/home_page.dart';
import 'package:gosuoflife/market_page.dart';
import 'package:gosuoflife/rank_service.dart';
import 'package:gosuoflife/stopwatch.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'auth_service.dart';
import 'login_page.dart';
import 'onboard_page.dart';

late SharedPreferences prefs;
late RankService rankService;

late Color primaryColor = Color.fromRGBO(60, 179, 113, 1);

const Map<String, String> UNIT_ID = kReleaseMode
    ? {
        'ios': 'ca-app-pub-6754544778509872/9486325432',
        'android': 'ca-app-pub-6754544778509872/5889861206',
      }
    : {
        'ios': 'ca-app-pub-3940256099942544/2934735716',
        'android': 'ca-app-pub-3940256099942544/6300978111',
      };

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //MobileAds.instance.initialize();

  prefs = await SharedPreferences.getInstance();

  try {
    if (Platform.isAndroid || Platform.isIOS) {
      await Firebase.initializeApp();
    } else {
      await Firebase.initializeApp(
          options: FirebaseOptions(
              apiKey: "AIzaSyDwSvChjV2rfAqPEZ8_dcVm-brZxj08UQs",
              appId: "1:266701313002:android:8c5d19027cd15e5f6c1893",
              messagingSenderId: "266701313002",
              projectId: "touch-party-67378457"));
    }
  } catch (e) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDwSvChjV2rfAqPEZ8_dcVm-brZxj08UQs",
            appId: "1:266701313002:android:8c5d19027cd15e5f6c1893",
            messagingSenderId: "266701313002",
            projectId: "touch-party-67378457"));
  }

  try {
    if (Platform.isAndroid || Platform.isIOS) {
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => AuthService()),
            ChangeNotifierProvider(create: (context) => RankService()),
          ],
          child: const MyApp(),
        ),
      );
    } else {
      runApp(MyApp());
    }
  } catch (e) {
    runApp(MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TargetPlatform os = Theme.of(context).platform;
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        //bool isOnBoarded = prefs.getBool("isOnBoarded") ?? false;
        final user = context.read<AuthService>().currentUser();
        rankService = context.read<RankService>();
        return MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme,
            //textTheme: GoogleFonts.getTextTheme('Jua'),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkColorScheme,
          ),
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          home: (user == null) ? LoginPage() : MarketPage(),
        );
      } else {
        return MaterialApp(home: MarketPage());
      }
    } catch (e) {
      return MaterialApp(home: MarketPage());
    }
  }
}
