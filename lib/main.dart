import 'package:aplication_laboratorio/pages/home_title.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:provider/provider.dart';
import 'providers/settings_provider.dart';
import 'pages/preferencias.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => SettingsProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, child) {
        return MaterialApp(
          title: 'EduFam',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 26, 128, 142),
              brightness: settings.isDarkMode ? Brightness.dark : Brightness.light,
            ),
            cardColor: settings.isDarkMode
                ? const Color(0xFF23272E) // Un gris azulado para oscuro
                : const Color(0xFFF5F5F5), // Un gris claro para claro
            fontFamily: 'Arial',
            brightness: settings.isDarkMode ? Brightness.dark : Brightness.light,
            textTheme: (settings.isDarkMode
                ? const TextTheme(
                    bodyMedium: TextStyle(color: Colors.white, fontSize: 16),
                    bodySmall: TextStyle(color: Colors.white70, fontSize: 14),
                    titleLarge: TextStyle(color: Colors.white, fontSize: 20),
                  )
                : const TextTheme(
                    bodyMedium: TextStyle(color: Colors.black, fontSize: 16),
                    bodySmall: TextStyle(color: Colors.black87, fontSize: 14),
                    titleLarge: TextStyle(color: Colors.black, fontSize: 20),
                  )
              ).apply(
                fontSizeFactor: settings.fontSize / 16.0, // <-- Esto aplica el tamaño global
              ),
          ),
          home: AnimatedSplashScreen(
            duration: 3000,
            splash: Image.asset('assets/edufam.png',fit: BoxFit.cover,width: 100,),
            nextScreen: HomeTitle(),
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: const Color.fromARGB(255, 255, 221, 174)),
        );
      },
    );
  }
}
