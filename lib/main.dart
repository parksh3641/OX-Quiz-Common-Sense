import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gosuoflife/home_page.dart';
import 'package:gosuoflife/market_page.dart';
import 'package:gosuoflife/rank_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'auth_service.dart';
import 'login_page.dart';
import 'onboard_page.dart';

late SharedPreferences prefs;
late RankService rankService;

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
    TargetPlatform os = Theme.of(context).platform;

    BannerAd banner = BannerAd(
      adUnitId: UNIT_ID[os == TargetPlatform.iOS ? 'ios' : 'android']!,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdFailedToLoad: (Ad ad, LoadAdError error) {},
        onAdLoaded: (_) {},
      ),
    )..load();

    bool isOnBoarded = prefs.getBool("isOnBoarded") ?? false;
    final user = context.read<AuthService>().currentUser();
    rankService = context.read<RankService>();
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: Colors.blue,
        textTheme: GoogleFonts.getTextTheme('Nanum Gothic'),
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
