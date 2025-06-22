import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserProfile {
  int id;
  String nombre;
  String correo;
  String contrasena;
  String direccion;
  String telefono;
  String colegio;

  UserProfile({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.contrasena,
    required this.direccion,
    required this.telefono,
    required this.colegio,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'nombre': nombre,
        'correo': correo,
        'contrasena': contrasena,
        'direccion': direccion,
        'telefono': telefono,
        'colegio': colegio,
      };

  static UserProfile fromMap(Map<String, dynamic> map) => UserProfile(
        id: map['id'],
        nombre: map['nombre'],
        correo: map['correo'],
        contrasena: map['contrasena'],
        direccion: map['direccion'],
        telefono: map['telefono'],
        colegio: map['colegio'],
      );
}

class UserDB {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await openDatabase(
      join(await getDatabasesPath(), 'user_profile.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE user(id INTEGER PRIMARY KEY, nombre TEXT, correo TEXT, contrasena TEXT, direccion TEXT, telefono TEXT, colegio TEXT)',
        );
      },
      version: 1,
    );
    return _db!;
  }

  static Future<void> insertOrUpdateUser(UserProfile user) async {
    final db = await database;
    await db.insert(
      'user',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<UserProfile> getUser() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('user');
    if (maps.isNotEmpty) {
      return UserProfile.fromMap(maps.first);
    } else {
      // Usuario por defecto
      final defaultUser = UserProfile(
        id: 1,
        nombre: 'Usuario',
        correo: 'userpadre@institucion.nombre.cl',
        contrasena: '***********',
        direccion: 'calle salmo*******',
        telefono: '+56947*******',
        colegio: 'Colegio San Mamasemamakusa',
      );
      await insertOrUpdateUser(defaultUser);
      return defaultUser;
    }
  }
}