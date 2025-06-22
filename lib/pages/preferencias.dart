import 'package:aplication_laboratorio/pages/acerca_de.dart';
import 'package:flutter/material.dart';

class Preferencias extends StatefulWidget {
  const Preferencias({super.key});

  @override
  State<Preferencias> createState() => _PreferenciasState();
}

class _PreferenciasState extends State<Preferencias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preferencias')),
      body: Column(
        children: <Widget>[
          Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Centra verticalmente
                    children: <Widget>[
                      OverflowBar(
                        alignment: MainAxisAlignment.center,
                        children: [
                          Text("Tamaño Fuente",),
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
                    mainAxisAlignment: MainAxisAlignment.center, // Centra verticalmente
                    children: <Widget>[
                      OverflowBar(
                        alignment: MainAxisAlignment.center,
                        children: [
                          Text("Tema",),
                          const Icon(
                            Icons.theater_comedy,
                            size: 80,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Centra verticalmente
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
