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
    final textColor = Theme.of(context).textTheme.bodyMedium?.color;
    final cardColor = Theme.of(context).cardColor;
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
              Icon(Icons.person, size: 80, color: Theme.of(context).iconTheme.color),
              const SizedBox(height: 16),
              Text(
                'Bienvenido, "${user?.nombre ?? "Usuario"}"',
                style: TextStyle(fontSize: 20, color: textColor),
              ),
              const SizedBox(height: 24),
              SizedBox(
                child: TableCalendar<ActividadEntrega>(
                  rowHeight: 43,
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleTextStyle: TextStyle(color: textColor),
                  ),
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
                              color: Theme.of(context).colorScheme.error,
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
              Text("Actividades Pendientes:", style: TextStyle(color: textColor)),
              Column(
                children: actividades
                    .where((a) => a.fecha.isAfter(DateTime.now().subtract(const Duration(days: 1))))
                    .map((a) => Card(
                          color: cardColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              OverflowBar(
                                alignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${_nombreDia(a.fecha)}, ${a.fecha.day.toString().padLeft(2, '0')}/${a.fecha.month.toString().padLeft(2, '0')}/${a.fecha.year}",
                                    style: TextStyle(color: textColor),
                                  ),
                                  Icon(
                                    Icons.dangerous,
                                    size: 80,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                  Text(a.descripcion, style: TextStyle(color: textColor)),
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
              Icon(Icons.note, color: Theme.of(context).iconTheme.color),
              Text('Promedio', style: TextStyle(color: textColor))
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
              Icon(Icons.person, color: Theme.of(context).iconTheme.color),
              Text('Perfil', style: TextStyle(color: textColor))
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
            children: [
              Icon(Icons.book, color: Theme.of(context).iconTheme.color),
              Text('Ramos', style: TextStyle(color: textColor))
            ],
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
              Icon(Icons.settings, color: Theme.of(context).iconTheme.color),
              Text('Configuracion', style: TextStyle(color: textColor))
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
