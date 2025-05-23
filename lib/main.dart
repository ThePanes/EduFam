import 'package:aplication_laboratorio/pages/home_title.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'EduFam',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 26, 128, 142),
        ),
        fontFamily: 'Arial',
      ),
      home: AnimatedSplashScreen(
            duration: 3000,
            splash: Image.asset('assets/edufam.png',fit: BoxFit.cover,width: 100,),
            nextScreen: HomeTitle(),
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: const Color.fromARGB(255, 255, 221, 174)));
  }
}
