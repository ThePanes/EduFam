import 'package:flutter/material.dart';
import 'package:aplication_laboratorio/data/nota_db.dart';

class Notas extends StatefulWidget {
  const Notas({super.key});

  @override
  State<Notas> createState() => _NotasState();
}

class _NotasState extends State<Notas> {
  late Future<Map<String, double?>> promediosPorRamo;

  @override
  void initState() {
    super.initState();
    promediosPorRamo = _calcularPromedios();
  }

  Future<Map<String, double?>> _calcularPromedios() async {
    final notas = await NotaDB.getAllNotas();
    // Lista de todos los ramos posibles
    final ramos = {'Matemáticas', 'Lenguaje', 'Historia'};
    final Map<String, List<double>> agrupadas = {};
    for (var n in notas) {
      if (n.nota != null) {
        agrupadas.putIfAbsent(n.ramo, () => []).add(n.nota!);
      }
    }
    // Asegura que todos los ramos estén presentes aunque no tengan notas
    for (var ramo in ramos) {
      agrupadas.putIfAbsent(ramo, () => []);
    }
    // Si no hay notas evaluadas, retorna null para ese ramo
    return agrupadas.map((ramo, notas) => MapEntry(
      ramo,
      notas.isEmpty ? null : notas.reduce((a, b) => a + b) / notas.length
    ));
  }

  void _verNotasRamo(String ramo) async {
    final notas = await NotaDB.getNotasPorRamo(ramo);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Notas de $ramo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: notas.map((n) => Text('${n.unidad}: ${n.nota?.toStringAsFixed(1) ?? "Aún sin evaluar"}')).toList(),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cerrar'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Promedio')),
      body: FutureBuilder<Map<String, double?>>(
        future: promediosPorRamo,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final promedios = snapshot.data!;
          return GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: promedios.entries.map((entry) => GestureDetector(
              onTap: () => _verNotasRamo(entry.key),
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(entry.key, textAlign: TextAlign.center),
                    const SizedBox(height: 10),
                    entry.value == null
                      ? const Text("Sin notas evaluadas", style: TextStyle(color: Colors.orange))
                      : Text("Promedio: ${entry.value!.toStringAsFixed(1)}"),
                  ],
                ),
              ),
            )).toList(),
          );
        },
      ),
    );
  }
}