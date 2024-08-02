import 'package:flappy_bird_game/game/assets.dart';
import 'package:flappy_bird_game/game/flappy_bird_game.dart';
import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

class MainMenuScreen extends StatefulWidget {
  final FlappyBirdGame game;
  static const String id = 'mainMenu';

  const MainMenuScreen({
    Key? key,
    required this.game,
  }) : super(key: key);

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {

  // BannerAd bAd = new BannerAd(size: AdSize.banner, adUnitId: 'ca-app-pub-2792610804820532/8204852446', listener: 
  // BannerAdListener(
  //  onAdLoaded: (Ad ad){
  //   print('Add loaded');
  //  }
  // ), request: request)
  @override
  Widget build(BuildContext context) {
    widget.game.pauseEngine();

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          widget.game.overlays.remove('mainMenu');
          widget.game.resumeEngine();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.menu),
              fit: BoxFit.cover,
            ),
          ),
          child: Image.asset(Assets.message),
        ),
      ),
    );
  }
}
