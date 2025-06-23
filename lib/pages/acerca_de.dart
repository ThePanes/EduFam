import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class AcercaDe extends StatefulWidget {
  const AcercaDe({super.key});

  @override
  State<AcercaDe> createState() => _AcercaDeState();
}

class _AcercaDeState extends State<AcercaDe> {
  Future<void> _mostrarCuestionario() async {
    final nombreCtrl = TextEditingController();
    final correoCtrl = TextEditingController();

    // Preguntas según el formato del documento
    final usabilidad = [
      {
        "titulo": "¿Qué tan fácil fue navegar a través de la aplicación?",
        "valor": 0.0,
        "min": "0 estrellas: Fue muy difícil encontrar las funcionalidades, la navegación fue confusa.",
        "max": "5 estrellas: Fue extremadamente fácil, la navegación es intuitiva y sin complicaciones."
      },
      {
        "titulo": "¿Pudiste completar tus tareas en la aplicación sin problemas?",
        "valor": 0.0,
        "min": "0 estrellas: No pude completar las tareas, fue frustrante.",
        "max": "5 estrellas: Pude completar todas las tareas de forma rápida y eficiente."
      },
      {
        "titulo": "¿Cómo calificas la interfaz gráfica en términos de diseño y claridad?",
        "valor": 0.0,
        "min": "0 estrellas: La interfaz es poco clara y difícil de entender.",
        "max": "5 estrellas: La interfaz es clara, atractiva y facilita el uso."
      },
    ];
    final contenido = [
      {
        "titulo": "¿El contenido de la aplicación fue útil para ti?",
        "valor": 0.0,
        "min": "0 estrellas: El contenido no fue relevante ni útil.",
        "max": "5 estrellas: El contenido fue muy útil y relevante para mis necesidades."
      },
      {
        "titulo": "¿Qué tan bien el contenido de la aplicación se adapta a tus expectativas?",
        "valor": 0.0,
        "min": "0 estrellas: El contenido no cumplió con mis expectativas.",
        "max": "5 estrellas: El contenido superó completamente mis expectativas."
      },
      {
        "titulo": "¿El contenido de la aplicación está presentado de manera clara y comprensible?",
        "valor": 0.0,
        "min": "0 estrellas: El contenido está mal estructurado o es confuso.",
        "max": "5 estrellas: El contenido está muy bien presentado y es fácil de comprender."
      },
    ];
    final compartir = [
      {
        "titulo": "¿Qué tan probable es que recomiendes esta aplicación a un amigo?",
        "valor": 0.0,
        "min": "0 estrellas: No la recomendaría en absoluto.",
        "max": "5 estrellas: Definitivamente la recomendaría."
      },
      {
        "titulo": "¿Cómo te sentirías al compartir esta aplicación con alguien más?",
        "valor": 0.0,
        "min": "0 estrellas: No me sentiría cómodo compartiéndola.",
        "max": "5 estrellas: Me sentiría muy cómodo compartiéndola."
      },
      {
        "titulo": "¿Crees que esta aplicación podría ser útil para personas cercanas a ti?",
        "valor": 0.0,
        "min": "0 estrellas: No creo que sea útil para otras personas.",
        "max": "5 estrellas: Estoy seguro de que sería muy útil para personas cercanas."
      },
    ];

    await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Danos tu opinión'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nombreCtrl,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                ),
                TextField(
                  controller: correoCtrl,
                  decoration: const InputDecoration(labelText: 'Correo'),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),
                const Text('Usabilidad', style: TextStyle(fontWeight: FontWeight.bold)),
                ...usabilidad.asMap().entries.map((entry) {
                  final i = entry.key;
                  final pregunta = entry.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text((pregunta["titulo"] ?? "").toString()),
                      Slider(
                        min: 0,
                        max: 5,
                        divisions: 5,
                        value: pregunta["valor"] as double,
                        label: (pregunta["valor"] as double).toStringAsFixed(0),
                        onChanged: (value) {
                          setState(() {
                            usabilidad[i]["valor"] = value;
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(child: Text((pregunta["min"] ?? "").toString(), style: const TextStyle(fontSize: 10))),
                          Flexible(child: Text((pregunta["max"] ?? "").toString(), style: const TextStyle(fontSize: 10))),
                        ],
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 10),
                const Text('Contenido', style: TextStyle(fontWeight: FontWeight.bold)),
                ...contenido.asMap().entries.map((entry) {
                  final i = entry.key;
                  final pregunta = entry.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text((pregunta["titulo"] ?? "").toString()),
                      Slider(
                        min: 0,
                        max: 5,
                        divisions: 5,
                        value: pregunta["valor"] as double,
                        label: (pregunta["valor"] as double).toStringAsFixed(0),
                        onChanged: (value) {
                          setState(() {
                            contenido[i]["valor"] = value;
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(child: Text((pregunta["min"] ?? "").toString(), style: const TextStyle(fontSize: 10))),
                          Flexible(child: Text((pregunta["max"] ?? "").toString(), style: const TextStyle(fontSize: 10))),
                        ],
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 10),
                const Text('Compartir', style: TextStyle(fontWeight: FontWeight.bold)),
                ...compartir.asMap().entries.map((entry) {
                  final i = entry.key;
                  final pregunta = entry.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text((pregunta["titulo"] ?? "").toString()),
                      Slider(
                        min: 0,
                        max: 5,
                        divisions: 5,
                        value: pregunta["valor"] as double,
                        label: (pregunta["valor"] as double).toStringAsFixed(0),
                        onChanged: (value) {
                          setState(() {
                            compartir[i]["valor"] = value;
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(child: Text((pregunta["min"] ?? "").toString(), style: const TextStyle(fontSize: 10))),
                          Flexible(child: Text((pregunta["max"] ?? "").toString(), style: const TextStyle(fontSize: 10))),
                        ],
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Enviar'),
            ),
          ],
        ),
      ),
    ).then((result) async {
      if (result == true) {
        final respuesta = {
          "nombre": nombreCtrl.text,
          "email": correoCtrl.text,
          "usabilidad": usabilidad.map((p) => {
            "titulo": p["titulo"],
            "valor": (p["valor"] as double).round(),
          }).toList(),
          "contenido": contenido.map((p) => {
            "titulo": p["titulo"],
            "valor": (p["valor"] as double).round(),
          }).toList(),
          "compartir": compartir.map((p) => {
            "titulo": p["titulo"],
            "valor": (p["valor"] as double).round(),
          }).toList(),
        };

        // Guardar en archivo JSON local (como array)
        final dir = await getApplicationDocumentsDirectory();
        final file = File('${dir.path}/cuestionario_opinion.json');
        List<dynamic> respuestas = [];
        if (await file.exists()) {
          final contenido = await file.readAsString();
          if (contenido.isNotEmpty) {
            respuestas = jsonDecode(contenido);
          }
        }
        respuestas.add(respuesta);
        await file.writeAsString(jsonEncode(respuestas), mode: FileMode.write);

        // Enviar automáticamente por correo
        await compartirArchivoCuestionario();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('¡Gracias por tu opinión!')),
          );
        }
      }
    });
  }

  Future<void> compartirArchivoCuestionario() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/cuestionario_opinion.json');
    if (await file.exists()) {
      final correo = 'oscar.montecinos.guerrero@gmail.com'; // Cambia por el correo del docente
      final asunto = Uri.encodeComponent('Respuestas cuestionario app EduFam');
      final cuerpo = Uri.encodeComponent('Adjunto archivo con mis respuestas.');
      final uri = Uri(
        scheme: 'mailto',
        path: correo,
        query: 'subject=$asunto&body=$cuerpo',
      );
      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Respuestas del cuestionario',
        sharePositionOrigin: Rect.zero,
        subject: 'Respuestas cuestionario app EduFam',
        // El paquete share_plus abrirá el cliente de correo con el archivo adjunto.
      );
      // Opcional: también puedes abrir el mailto: link para asegurar el destinatario
      // await launchUrl(uri); // requiere url_launcher
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No hay archivo de cuestionario para compartir.')),
      );
    }
  }

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
              onPressed: _mostrarCuestionario,
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
            TextButton.icon(
              icon: const Icon(Icons.send),
              label: const Text('Enviar archivo por correo'),
              onPressed: compartirArchivoCuestionario,
            ),
          ],
        ),
      ),
    );
  }
}