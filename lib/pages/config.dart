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
    return Scaffold(
      appBar: AppBar(title: const Text('Configuracion')),
      body: Column(
        children: <Widget>[
          OverflowBar(
            alignment: MainAxisAlignment.center,
            children: [
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
                              MaterialPageRoute(builder: (context) => const Preferencias()),
                            );
                          },
                          child: Column(
                            children: [
                              const Icon(Icons.room_preferences),
                              const Text('Preferencias'),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Centra verticalmente
                    children: <Widget>[
                      OverflowBar(
                        alignment: MainAxisAlignment.center,
                        children: [
                          Text("Cerrar Sesion",),
                          const Icon(
                            Icons.close,
                            size: 80,
                            color: Color.fromARGB(255, 242, 5, 5),
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