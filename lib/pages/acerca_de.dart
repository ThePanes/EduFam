import 'package:flutter/material.dart';

class AcercaDe extends StatefulWidget {
  const AcercaDe({super.key});

  @override
  State<AcercaDe> createState() => _AcercaDeState();
}
class _AcercaDeState extends State<AcercaDe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Acerca de')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text('Informacion del Desarrollador: \ncreado por: Oscar Montecinos Guerrero. \nRamo: Programacion de dispositivos Mobiles', 
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 80),
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
                              const Text('¿Te gusto la aplicacion? \n ¡Danos tu opinion!'),
                            ],
                          ),
                        ),

        ]
      ),
    );
  }
}