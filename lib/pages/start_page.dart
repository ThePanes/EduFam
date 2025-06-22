import 'package:aplication_laboratorio/data/user_db.dart';
import 'package:aplication_laboratorio/pages/config.dart';
import 'package:aplication_laboratorio/pages/notas.dart';
import 'package:aplication_laboratorio/pages/profile.dart';
import 'package:aplication_laboratorio/pages/ramos.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  UserProfile? user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final loadedUser = await UserDB.getUser();
    setState(() {
      user = loadedUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    DateTime today = DateTime.now();

    // Crea un mapa de eventos por fecha
    Map<DateTime, List<ActividadEntrega>> eventosPorFecha = {};
    for (var act in actividades) {
      final fecha = DateTime(act.fecha.year, act.fecha.month, act.fecha.day);
      eventosPorFecha.putIfAbsent(fecha, () => []).add(act);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Pagina de Inicio')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Icon(Icons.person, size: 80, color: Colors.blueGrey),
              const SizedBox(height: 16),
              Text('Bienvenido, "${user?.nombre ?? "Usuario"}"', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 24),
              SizedBox(
                child: TableCalendar<ActividadEntrega>(
                  rowHeight: 43,
                  headerStyle: HeaderStyle(formatButtonVisible: false),
                  focusedDay: today,
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  eventLoader: (day) {
                    final key = DateTime(day.year, day.month, day.day);
                    return eventosPorFecha[key] ?? [];
                  },
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, date, events) {
                      if (events.isNotEmpty) {
                        return Positioned(
                          right: 1,
                          bottom: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            width: 8,
                            height: 8,
                          ),
                        );
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text("Actividades Pendientes:"),
              Column(
                children: actividades
                    .where((a) => a.fecha.isAfter(DateTime.now().subtract(const Duration(days: 1))))
                    .map((a) => Card(
                          color: a.ramo == "Matemáticas"
                              ? Color.fromARGB(255, 253, 164, 164)
                              : a.ramo == "Lenguaje"
                                  ? Color.fromARGB(255, 235, 237, 105)
                                  : Color.fromARGB(255, 164, 222, 253),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              OverflowBar(
                                alignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${_nombreDia(a.fecha)}, ${a.fecha.day.toString().padLeft(2, '0')}/${a.fecha.month.toString().padLeft(2, '0')}/${a.fecha.year}",
                                  ),
                                  const Icon(
                                    Icons.dangerous,
                                    size: 80,
                                    color: Color.fromARGB(255, 253, 62, 62),
                                  ),
                                  Text(a.descripcion),
                                  const SizedBox(height: 20, width: 10),
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Notas()),
            );
          },
          child: Column(
            children: [
              const Icon(Icons.note),
              const Text('Promedio')
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Profile()),
            );
          },
          child: Column(
            children: [
              const Icon(Icons.person),
              const Text('Perfil')
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Ramos()),
            );
          },
          child: Column(
            children: [const Icon(Icons.book),const Text('Ramos')],
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Config()),
            );
          },
          child: Column(
            children: [
              const Icon(Icons.settings),
              const Text('Configuracion')
            ],
          ),
        ),
        
      ],

    );
  }
}

// Helper para mostrar el nombre del día
String _nombreDia(DateTime fecha) {
  const dias = [
    "Domingo",
    "Lunes",
    "Martes",
    "Miércoles",
    "Jueves",
    "Viernes",
    "Sábado"
  ];
  return dias[fecha.weekday % 7];
}

class ActividadEntrega {
  final DateTime fecha;
  final String ramo;
  final String descripcion;

  ActividadEntrega({required this.fecha, required this.ramo, required this.descripcion});
}

// Lista de actividades (puedes moverla a un archivo aparte si quieres)
final List<ActividadEntrega> actividades = [
  ActividadEntrega(
    fecha: DateTime(2025, 6, 23),
    ramo: "Matemáticas",
    descripcion: "Entrega tarea matemáticas - Unidad 1",
  ),
  ActividadEntrega(
    fecha: DateTime(2025, 6, 24),
    ramo: "Lenguaje",
    descripcion: "Entrega tarea lenguaje - Unidad 1",
  ),
];
