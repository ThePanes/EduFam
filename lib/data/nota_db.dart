import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotaEntrega {
  int id;
  String ramo;
  String unidad;
  double? nota; // null si aún no está evaluada

  NotaEntrega({required this.id, required this.ramo, required this.unidad, this.nota});

  Map<String, dynamic> toMap() => {
    'id': id,
    'ramo': ramo,
    'unidad': unidad,
    'nota': nota,
  };

  static NotaEntrega fromMap(Map<String, dynamic> map) => NotaEntrega(
    id: map['id'],
    ramo: map['ramo'],
    unidad: map['unidad'],
    nota: map['nota'] != null ? map['nota'] * 1.0 : null,
  );
}

class NotaDB {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await openDatabase(
      join(await getDatabasesPath(), 'notas_entregas.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notas(id INTEGER PRIMARY KEY, ramo TEXT, unidad TEXT, nota REAL)',
        );
      },
      version: 1,
    );
    return _db!;
  }

  static Future<void> insertOrUpdateNota(NotaEntrega nota) async {
    final db = await database;
    await db.insert(
      'notas',
      nota.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<NotaEntrega?> getNota(String ramo, String unidad) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'notas',
      where: 'ramo = ? AND unidad = ?',
      whereArgs: [ramo, unidad],
    );
    if (maps.isNotEmpty) {
      return NotaEntrega.fromMap(maps.first);
    }
    return null;
  }

  static Future<List<NotaEntrega>> getNotasPorRamo(String ramo) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'notas',
      where: 'ramo = ?',
      whereArgs: [ramo],
    );
    return maps.map((e) => NotaEntrega.fromMap(e)).toList();
  }

  static Future<List<NotaEntrega>> getAllNotas() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('notas');
    return maps.map((e) => NotaEntrega.fromMap(e)).toList();
  }
}