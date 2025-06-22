import 'package:flutter/material.dart';

class AcercaDe extends StatefulWidget {
  const AcercaDe({super.key});

  @override
  State<AcercaDe> createState() => _AcercaDeState();
}

class _AcercaDeState extends State<AcercaDe> {
  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyMedium?.color;
    final titleColor = Theme.of(context).textTheme.titleLarge?.color;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Acerca de',
          style: TextStyle(color: titleColor),
        ),
        iconTheme: IconThemeData(color: titleColor),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Información del Desarrollador:\nCreado por: Oscar Montecinos Guerrero.\nRamo: Programación de dispositivos Móviles',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 80),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('¡Gracias por tu opinión!')),
                );
              },
              child: Column(
                children: [
                  Icon(Icons.room_preferences, color: Theme.of(context).iconTheme.color),
                  Text(
                    '¿Te gustó la aplicación?\n¡Danos tu opinión!',
                    style: TextStyle(color: textColor),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}