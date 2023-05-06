import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:glucowizard_flutter/views/login_page.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        duration: 1000,
        splash: Column(children: [
          Image.asset('assets/images/Logo_app.png', height: 180, width: 180),
          SizedBox(height: 20),
          const Text(
            'DiyaSezi',
            style: TextStyle(
                fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
          )
        ]),
        nextScreen: LoginPage(),
        splashTransition: SplashTransition.sizeTransition,
        splashIconSize: 250,
        pageTransitionType: PageTransitionType.leftToRightWithFade,
        animationDuration: Duration(milliseconds: 1400),
        backgroundColor: Color(0xFF8e61d1));
  }
}
