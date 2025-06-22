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
    final textColor = Theme.of(context).textTheme.bodyMedium?.color;
    final cardColor = Theme.of(context).cardColor;
    return Scaffold(
      appBar: AppBar(title: const Text('Preferencias')),
      body: Column(
        children: <Widget>[
          Card(
            color: cardColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OverflowBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    Text("Tamaño Fuente", style: TextStyle(color: textColor)),
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
                    Text('${settings.fontSize.toStringAsFixed(0)} pt',
                        style: TextStyle(color: textColor)),
                    Icon(
                      Icons.font_download,
                      size: 80,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Card(
            color: cardColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OverflowBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    Text("Tema", style: TextStyle(color: textColor)),
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
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context).iconTheme.color,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Card(
            color: cardColor,
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
                          MaterialPageRoute(
                              builder: (context) => const AcercaDe()),
                        );
                      },
                      child: Column(
                        children: [
                          Icon(Icons.room_preferences,
                              color: Theme.of(context).iconTheme.color),
                          Text('Acerca de', style: TextStyle(color: textColor)),
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
