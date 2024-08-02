import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird_game/screens/main_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flappy_bird_game/game/flappy_bird_game.dart';
import 'package:flappy_bird_game/screens/game_over_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 1000,
      splash: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Image.asset(
              'assets/images/bird_midflap.png',
              width: 300,
              height: 300,
            ),
          ),
        ],
      ),
      splashIconSize: 4000,
      nextScreen: const GameWrapper(),
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Colors.white,
    );
  }
}

class GameWrapper extends StatelessWidget {
  const GameWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final game = FlappyBirdGame();
    return GameWidget(
      game: game,
      overlayBuilderMap: {
        'mainMenu': (context, _) => MainMenuScreen(game: game),
        'gameOver': (context, _) => GameOverScreen(game: game),
      },
      initialActiveOverlays: ['mainMenu'], // Show mainMenu overlay initially
    );
  }
}
