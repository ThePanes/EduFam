import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/settings_provider.dart';
import 'pages/home_title.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => SettingsProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
                ? const Color(0xFF23272E)
                : const Color(0xFFF5F5F5),
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
                fontSizeFactor: settings.fontSize / 16.0,
              ),
          ),
          home: AnimatedSplashScreen(
            duration: 3000,
            splash: Image.asset('assets/edufam.png', fit: BoxFit.cover, width: 100,),
            nextScreen: HomeTitle(),
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: const Color.fromARGB(255, 255, 221, 174)),
        );
      },
    );
  }
}
