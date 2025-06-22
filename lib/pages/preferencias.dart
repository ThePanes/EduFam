import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';
import 'acerca_de.dart';

class Preferencias extends StatefulWidget {
  const Preferencias({super.key});

  @override
  State<Preferencias> createState() => _PreferenciasState();
}

class _PreferenciasState extends State<Preferencias> {
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Preferencias')),
      body: Column(
        children: <Widget>[
          Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OverflowBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    const Text("Tamaño Fuente"),
                    Slider(
                      min: 12,
                      max: 28,
                      divisions: 8,
                      value: settings.fontSize,
                      label: settings.fontSize.toStringAsFixed(0),
                      onChanged: (value) {
                        settings.setFontSize(value);
                      },
                    ),
                    Text('${settings.fontSize.toStringAsFixed(0)} pt'),
                    const Icon(
                      Icons.font_download,
                      size: 80,
                      color: Color.fromARGB(255, 125, 176, 206),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OverflowBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    const Text("Tema"),
                    Switch(
                      value: settings.isDarkMode,
                      onChanged: (value) {
                        settings.toggleDarkMode(value);
                      },
                    ),
                    Icon(
                      settings.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                      size: 80,
                      color: settings.isDarkMode
                          ? Colors.amber
                          : const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OverflowBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AcercaDe()),
                        );
                      },
                      child: Column(
                        children: [
                          const Icon(Icons.room_preferences),
                          const Text('Acerca de'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
