import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aplication_laboratorio/pages/start_page.dart';
import 'package:aplication_laboratorio/data/nota_db.dart';

class Ramos extends StatefulWidget {
  const Ramos({super.key});

  @override
  State<Ramos> createState() => _RamosState();
}

class _RamosState extends State<Ramos> {
  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyMedium?.color;
    return Scaffold(
      appBar: AppBar(title: const Text('Ramos')),
      body: Column(
        children: <Widget>[
          OverflowBar(
            alignment: MainAxisAlignment.center,
            children: [
              Card(
                color: Theme.of(context).cardColor,
                clipBehavior: Clip.antiAlias,
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
                              MaterialPageRoute(builder: (context) => const Mathmatics()),
                            );
                          },
                          child: Column(
                            children: [
                              Text("Matematicas", style: TextStyle(color: textColor)),
                              SizedBox(
                                width: 400,
                                height: 100,
                                child: Image.asset('assets/matematicasensenanzamedia.jpg', fit: BoxFit.cover,),
                              ),
                              Text("Curso: 8B", style: TextStyle(color: textColor)),
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
                color: Theme.of(context).cardColor,
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
                              MaterialPageRoute(builder: (context) => const Languaje()),
                            );
                          },
                          child: Column(
                            children: [
                              Text("Lenguaje", style: TextStyle(color: textColor)),
                              SizedBox(
                                width: 400,
                                height: 100,
                                child: Image.asset('assets/len.jpg', fit: BoxFit.cover,),
                              ),
                              Text("Curso: 8B", style: TextStyle(color: textColor)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
              Card(
                color: Theme.of(context).cardColor,
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
                              MaterialPageRoute(builder: (context) => const History()),
                            );
                          },
                          child: Column(
                            children: [
                              Text("Historia", style: TextStyle(color: textColor)),
                              SizedBox(
                                width: 400,
                                height: 100,
                                child: Image.asset('assets/historia.jpg', fit: BoxFit.cover,),
                              ),
                              Text("Curso: 8B", style: TextStyle(color: textColor)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
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
/////////////////////////////////////////WIDGETS DE LOS RAMOS/////////////////////////////////
class Mathmatics extends StatefulWidget {
  const Mathmatics({super.key});

  @override
  State<Mathmatics> createState() => _MathmaticsState();
}
class _MathmaticsState extends State<Mathmatics> {
  @override
  Widget build(BuildContext context) {
    final actividad1 = actividades.firstWhere(
      (a) => a.ramo == "Matemáticas" && a.descripcion.contains("Unidad 1"),
      orElse: () => ActividadEntrega(
        fecha: DateTime(2100),
        ramo: "Matemáticas",
        descripcion: "Sin entrega programada",
      ),
    );
    final actividad2 = actividades.firstWhere(
      (a) => a.ramo == "Matemáticas" && a.descripcion.contains("Unidad 2"),
      orElse: () => ActividadEntrega(
        fecha: DateTime(2100),
        ramo: "Matemáticas",
        descripcion: "Sin entrega programada",
      ),
    );
    final actividad3 = actividades.firstWhere(
      (a) => a.ramo == "Matemáticas" && a.descripcion.contains("Unidad 3"),
      orElse: () => ActividadEntrega(
        fecha: DateTime(2100),
        ramo: "Matemáticas",
        descripcion: "Sin entrega programada",
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Matematicas')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text("Informacion del Modulo:", textScaleFactor: 2,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.picture_as_pdf,
                  size: 40,
                  color: Color.fromARGB(255, 220, 56, 56),
                ),
                const Icon(
                  Icons.download,
                  size: 40,
                  color: Color.fromARGB(255, 255, 86, 86),
                ),
                Text("Plan de Clases", textScaleFactor: 2,),
                SizedBox(width: 50,),
                const Icon(
                  Icons.picture_as_pdf,
                  size: 40,
                  color: Color.fromARGB(255, 220, 56, 56),
                ),
                const Icon(
                  Icons.download,
                  size: 40,
                  color: Color.fromARGB(255, 255, 86, 86),
                ),
                Text("Reuniones de Apoderados", textScaleFactor: 2,),
              ],
            ),
            // Unidad 1
            Card(
              child: Column(
                children: [
                  OverflowBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      Text("Unidad 1: Potencias"),
                      const Icon(Icons.arrow_downward, size: 40, color: Color.fromARGB(255, 255, 86, 86)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  EntregaActividad(
                    storageKey: 'math_unidad1',
                    tituloUnidad: 'Entrega: Foto de la actividad de Matemáticas - Unidad 1',
                    ramo: 'Matemáticas',
                    unidad: 'Unidad 1',
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            // Unidad 2
            Card(
              child: Column(
                children: [
                  OverflowBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      Text("Unidad 2: Potencias con Fracciones"),
                      const Icon(Icons.arrow_downward, size: 40, color: Color.fromARGB(255, 255, 86, 86)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  EntregaActividad(
                    storageKey: 'math_unidad2',
                    tituloUnidad: actividad2 != null
                        ? 'Entrega: Foto de la actividad de Matemáticas - Unidad 2\nFecha entrega: ${actividad2.fecha.day.toString().padLeft(2, '0')}/${actividad2.fecha.month.toString().padLeft(2, '0')}/${actividad2.fecha.year}'
                        : 'Entrega: Foto de la actividad de Matemáticas - Unidad 2',
                    ramo: 'Matemáticas',
                    unidad: 'Unidad 2',
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            // Unidad 3
            Card(
              child: Column(
                children: [
                  OverflowBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      Text("Unidad 3: Potencias y más potencias"),
                      const Icon(Icons.arrow_downward, size: 40, color: Color.fromARGB(255, 255, 86, 86)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  EntregaActividad(
                    storageKey: 'math_unidad3',
                    tituloUnidad: actividad3 != null
                        ? 'Entrega: Foto de la actividad de Matemáticas - Unidad 3\nFecha entrega: ${actividad3.fecha.day.toString().padLeft(2, '0')}/${actividad3.fecha.month.toString().padLeft(2, '0')}/${actividad3.fecha.year}'
                        : 'Entrega: Foto de la actividad de Matemáticas - Unidad 3',
                    ramo: 'Matemáticas',
                    unidad: 'Unidad 3',
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            // Notas del ramo
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  OverflowBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      Text("NOTAS DEL RAMO"),
                      const Icon(
                        Icons.arrow_downward,
                        size: 40,
                        color: Color.fromARGB(255, 255, 86, 86),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Languaje extends StatefulWidget {
  const Languaje({super.key});

  @override
  State<Languaje> createState() => _LanguajeState();
}
class _LanguajeState extends State<Languaje> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lenguaje')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text("Informacion del Modulo:", textScaleFactor: 2,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.picture_as_pdf,
                  size: 40,
                  color: Color.fromARGB(255, 220, 56, 56),
                ),
                const Icon(
                  Icons.download,
                  size: 40,
                  color: Color.fromARGB(255, 255, 86, 86),
                ),
                Text("Plan de Clases", textScaleFactor: 2,),
                SizedBox(width: 50,),
                const Icon(
                  Icons.picture_as_pdf,
                  size: 40,
                  color: Color.fromARGB(255, 220, 56, 56),
                ),
                const Icon(
                  Icons.download,
                  size: 40,
                  color: Color.fromARGB(255, 255, 86, 86),
                ),
                Text("Reuniones de Apoderados", textScaleFactor: 2,),
              ],
            ),
            // Unidad 1
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  OverflowBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      Text("Unidad 1: Cuentos"),
                      const Icon(
                        Icons.arrow_downward,
                        size: 40,
                        color: Color.fromARGB(255, 255, 86, 86),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  EntregaActividad(
                    storageKey: 'lenguaje_unidad1',
                    tituloUnidad: 'Entrega: Foto de la actividad de Lenguaje - Unidad 1',
                    ramo: 'Lenguaje',
                    unidad: 'Unidad 1',
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            // Unidad 2
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  OverflowBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      Text("Unidad 2: Fabulas"),
                      const Icon(
                        Icons.arrow_downward,
                        size: 40,
                        color: Color.fromARGB(255, 255, 86, 86),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  EntregaActividad(
                    storageKey: 'lenguaje_unidad2',
                    tituloUnidad: 'Entrega: Foto de la actividad de Lenguaje - Unidad 2',
                    ramo: 'Lenguaje',
                    unidad: 'Unidad 2',
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            // Unidad 3
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  OverflowBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      Text("Unidad 3: Poemas"),
                      const Icon(
                        Icons.arrow_downward,
                        size: 40,
                        color: Color.fromARGB(255, 255, 86, 86),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  EntregaActividad(
                    storageKey: 'lenguaje_unidad3',
                    tituloUnidad: 'Entrega: Foto de la actividad de Lenguaje - Unidad 3',
                    ramo: 'Lenguaje',
                    unidad: 'Unidad 3',
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            // Notas del ramo
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  OverflowBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      Text("NOTAS DEL RAMO"),
                      const Icon(
                        Icons.arrow_downward,
                        size: 40,
                        color: Color.fromARGB(255, 255, 86, 86),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Historia')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text("Informacion del Modulo:", textScaleFactor: 2,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.picture_as_pdf,
                  size: 40,
                  color: Color.fromARGB(255, 220, 56, 56),
                ),
                const Icon(
                  Icons.download,
                  size: 40,
                  color: Color.fromARGB(255, 255, 86, 86),
                ),
                Text("Plan de Clases", textScaleFactor: 2,),
                SizedBox(width: 50,),
                const Icon(
                  Icons.picture_as_pdf,
                  size: 40,
                  color: Color.fromARGB(255, 220, 56, 56),
                ),
                const Icon(
                  Icons.download,
                  size: 40,
                  color: Color.fromARGB(255, 255, 86, 86),
                ),
                Text("Reuniones de Apoderados", textScaleFactor: 2,),
              ],
            ),
            // Unidad 1
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  OverflowBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      Text("Unidad 1: Historia siglo XVII"),
                      const Icon(
                        Icons.arrow_downward,
                        size: 40,
                        color: Color.fromARGB(255, 255, 86, 86),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  EntregaActividad(
                    storageKey: 'historia_unidad1',
                    tituloUnidad: 'Entrega: Foto de la actividad de Historia - Unidad 1',
                    ramo: 'Historia',
                    unidad: 'Unidad 1',
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            // Unidad 2
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  OverflowBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      Text("Unidad 2: Historia siglo XVIII"),
                      const Icon(
                        Icons.arrow_downward,
                        size: 40,
                        color: Color.fromARGB(255, 255, 86, 86),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  EntregaActividad(
                    storageKey: 'historia_unidad2',
                    tituloUnidad: 'Entrega: Foto de la actividad de Historia - Unidad 2',
                    ramo: 'Historia',
                    unidad: 'Unidad 2',
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            // Unidad 3
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  OverflowBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      Text("Unidad 3: Historia siglo XIX"),
                      const Icon(
                        Icons.arrow_downward,
                        size: 40,
                        color: Color.fromARGB(255, 255, 86, 86),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  EntregaActividad(
                    storageKey: 'historia_unidad3',
                    tituloUnidad: 'Entrega: Foto de la actividad de Historia - Unidad 3',
                    ramo: 'Historia',
                    unidad: 'Unidad 3',
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            // Notas del ramo
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  OverflowBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      Text("NOTAS DEL RAMO"),
                      const Icon(
                        Icons.arrow_downward,
                        size: 40,
                        color: Color.fromARGB(255, 255, 86, 86),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class EntregaActividad extends StatefulWidget {
  final String storageKey;
  final String tituloUnidad;
  final String ramo;
  final String unidad;
  const EntregaActividad({
    super.key,
    required this.storageKey,
    required this.tituloUnidad,
    required this.ramo,
    required this.unidad,
  });

  @override
  State<EntregaActividad> createState() => _EntregaActividadState();
}

class _EntregaActividadState extends State<EntregaActividad> {
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _loadImagePath();
  }

  Future<void> _loadImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString(widget.storageKey);
    if (path != null) {
      final file = File(path);
      if (await file.exists()) {
        setState(() {
          _imageFile = file;
        });
      } else {
        setState(() {
          _imageFile = null;
        });
      }
    } else {
      setState(() {
        _imageFile = null;
      });
    }
  }

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(widget.storageKey, pickedFile.path);

      // Al entregar, crea la nota si no existe
      final notaExistente = await NotaDB.getNota(widget.ramo, widget.unidad);
      if (notaExistente == null) {
        await NotaDB.insertOrUpdateNota(
          NotaEntrega(
            id: (widget.ramo + widget.unidad).hashCode,
            ramo: widget.ramo,
            unidad: widget.unidad,
            nota: null,
          ),
        );
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyMedium?.color;
    final secondaryColor = Theme.of(context).colorScheme.secondary;
    final primaryColor = Theme.of(context).colorScheme.primary;
    return Card(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              widget.tituloUnidad,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 10),
            _imageFile != null
                ? Image.file(_imageFile!, height: 150)
                : Text(
                    "No se ha subido ninguna foto.",
                    style: TextStyle(color: textColor),
                  ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () async {
                await _takePicture();
                await _loadImagePath();
              },
              icon: Icon(Icons.camera_alt, color: primaryColor),
              label: Text("Tomar foto y subir", style: TextStyle(color: textColor)),
            ),
            ElevatedButton(
              onPressed: () async {
                await NotaDB.insertOrUpdateNota(
                  NotaEntrega(
                    id: (widget.ramo + widget.unidad).hashCode,
                    ramo: widget.ramo,
                    unidad: widget.unidad,
                    nota: 4.2,
                  ),
                );
                setState(() {});
              },
              child: Text("Poner nota de prueba", style: TextStyle(color: textColor)),
            ),
            FutureBuilder<double?>(
              future: NotaDB.getNota(widget.ramo, widget.unidad).then((n) => n?.nota),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text("Cargando nota...", style: TextStyle(color: textColor));
                }
                final nota = snapshot.data;
                if (nota == null) {
                  return Text("Aún sin evaluar", style: TextStyle(color: secondaryColor));
                }
                return Text(
                  "Nota: ${nota.toStringAsFixed(1)}",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}