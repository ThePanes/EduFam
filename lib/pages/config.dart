import 'package:aplication_laboratorio/pages/preferencias.dart';
import 'package:flutter/material.dart';

class Config extends StatefulWidget {
  const Config({super.key});

  @override
  State<Config> createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyMedium?.color;
    final cardColor = Theme.of(context).cardColor;
    return Scaffold(
      appBar: AppBar(title: const Text('Configuracion')),
      body: Column(
        children: <Widget>[
          OverflowBar(
            alignment: MainAxisAlignment.center,
            children: [
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
                              MaterialPageRoute(builder: (context) => const Preferencias()),
                            );
                          },
                          child: Column(
                            children: [
                              Icon(Icons.room_preferences, color: Theme.of(context).iconTheme.color),
                              Text('Preferencias', style: TextStyle(color: textColor)),
                            ],
                          ),
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
                        Text("Cerrar Sesion", style: TextStyle(color: textColor)),
                        Icon(
                          Icons.close,
                          size: 80,
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}