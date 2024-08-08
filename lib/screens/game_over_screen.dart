import 'package:flappy_bird_game/game/assets.dart';
import 'package:flappy_bird_game/game/flappy_bird_game.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GameOverScreen extends StatefulWidget {
  final FlappyBirdGame game;

  const GameOverScreen({Key? key, required this.game}) : super(key: key);

  @override
  State<GameOverScreen> createState() => _GameOverScreenState();
}

class _GameOverScreenState extends State<GameOverScreen> {
  late BannerAd _bannerAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: 'ca-app-pub-2792610804820532/8204852446', // Test Ad Unit ID
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            _isAdLoaded = true;
          });
          print("Ad Loaded");
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          print("Ad failed to load: ${error.code} - ${error.message}");
        },
        onAdOpened: (Ad ad) {
          print("Ad opened");
        },
      ),
      request: AdRequest(),
    );
    _bannerAd.load();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.black38,
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Score: ${widget.game.bird.score}',
                    style: const TextStyle(
                      fontSize: 60,
                      color: Colors.white,
                      fontFamily: 'Game',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Highest Score: ${widget.game.bird.highestScore}',
                    style: const TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontFamily: 'Game',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.asset(Assets.gameOver),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: onRestart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    child: const Text(
                      'Restart',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            if (_isAdLoaded)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: _bannerAd.size.width.toDouble(),
                  height: _bannerAd.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd),
                ),
              ),
          ],
        ),
      );

  void onRestart() {
    widget.game.bird.reset();
    widget.game.overlays.remove('gameOver');
    widget.game.resumeEngine();
  }
}
