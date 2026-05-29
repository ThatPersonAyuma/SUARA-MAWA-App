import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:suara_mawa/screens/penindak/penindak_main_screen.dart';
import 'package:suara_mawa/utils/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SUARA MAWA',
      theme: ThemeData(
        fontFamily: 'PublicSans'
      ),
      home: AnimatedSplashScreen(
        splash: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', width: 180, height: 90),
            const SizedBox(height: 20),
            const Text(
              'SUARA MAWA',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Suarakan Aspirasimu',
              style: TextStyle(fontSize: 14, color: AppColors.subtext1),
            ),
          ],
        ),
        nextScreen: PenindakMainScreen(),
        splashTransition: SplashTransition.scaleTransition,
        pageTransitionType: PageTransitionType.fade,
        backgroundColor: AppColors.background,
        duration: 1500,
        animationDuration: const Duration(milliseconds: 500),
        splashIconSize: 300,
      ),
    );
  }
}