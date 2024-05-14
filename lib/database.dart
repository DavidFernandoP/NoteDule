//lib\database.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static const String _dbName = 'mydb.db';
  static const int _dbVersion = 1;

  // Singleton para asegurar que solo tengamos una instancia de la base de datos
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    // Código para crear las tablas en la base de datos
    await db.execute('''
      CREATE TABLE Horarios(
        idHorarios INTEGER PRIMARY KEY AUTOINCREMENT,
        Horario TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE apuntes(
        idapuntes INTEGER PRIMARY KEY,
        apunte_materia TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE Materias(
        idMaterias INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre_materia TEXT NOT NULL,
        profesor_materia TEXT NOT NULL,
        apuntes_idapuntes INT NOT NULL,
        Horarios_idHorarios INT NOT NULL,
        FOREIGN KEY (apuntes_idapuntes) REFERENCES apuntes (idapuntes) ON DELETE NO ACTION ON UPDATE NO ACTION,
        FOREIGN KEY (Horarios_idHorarios) REFERENCES Horarios (idHorarios) ON DELETE NO ACTION ON UPDATE NO ACTION
      )
    ''');

    await db.execute('''
      CREATE TABLE Eventos(
        idEventos INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre_evento TEXT NOT NULL,
        Horarios_idHorarios INT NOT NULL,
        FOREIGN KEY (Horarios_idHorarios) REFERENCES Horarios (idHorarios) ON DELETE NO ACTION ON UPDATE NO ACTION
      )
    ''');

    // Código para inicializar la base de datos con algunos datos iniciales
    await _initializeData(db);
  }

  Future<void> _initializeData(Database db) async {
    // Código para insertar datos iniciales en la base de datos, si es necesario
  }

  Future<List<Map<String, dynamic>>> getHorarios() async {
    try {
      Database db = await instance.database;
      return await db.query('Horarios');
    } catch (error) {
      print('Error al obtener los Horarios: $error');
      throw 'Error al obtener los Horarios: $error';
    }
  }

  Future<List<Map<String, dynamic>>> getMaterias() async {
    try {
      Database db = await instance.database;
      return await db.query('Materias');
    } catch (error) {
      print('Error al obtener las materias: $error');
      throw 'Error al obtener las materias: $error';
    }
  }

  Future<List<Map<String, dynamic>>> getHorarioDeMateria(int idMateria) async {
    try {
      Database db = await instance.database;
      return await db.rawQuery('''
        SELECT Materias.nombre_materia, Horarios.Horario
        FROM Materias 
        INNER JOIN Horarios ON Materias.Horarios_idHorarios = Horarios.idHorarios 
        WHERE Materias.idMaterias = ?;
      ''', [idMateria]);
    } catch (error) {
      print('Error al obtener el horario de la materia: $error');
      throw 'Error al obtener el horario de la materia: $error';
    }
  }

  Future<List<Map<String, dynamic>>> getApuntesConMaterias() async {
    try {
      Database db = await instance.database;
      return await db.rawQuery('''
        SELECT Materias.nombre_materia, apuntes.apunte_materia
        FROM apuntes
        INNER JOIN Materias ON apuntes.idapuntes = Materias.apuntes_idapuntes;
      ''');
    } catch (error) {
      print(
          'Error al obtener los apuntes con los nombres de las materias: $error');
      throw 'Error al obtener los apuntes con los nombres de las materias: $error';
    }
  }

  Future<List<Map<String, dynamic>>> getApuntesDeMateria(int idMateria) async {
    try {
      Database db = await instance.database;
      return await db.rawQuery('''
        SELECT Materias.nombre_materia, apuntes.apunte_materia
        FROM apuntes
        INNER JOIN Materias ON apuntes.idapuntes = Materias.apuntes_idapuntes
        WHERE Materias.idMaterias = ?;
      ''', [idMateria]);
    } catch (error) {
      print('Error al obtener los apuntes de la materia: $error');
      throw 'Error al obtener los apuntes de la materia: $error';
    }
  }

  Future<List<Map<String, dynamic>>> getEventosConHorarioYMateria() async {
    try {
      Database db = await instance.database;
      return await db.rawQuery('''
        SELECT Materias.nombre_materia, Horarios.Horario, Eventos.nombre_evento
        FROM Eventos
        INNER JOIN Horarios ON Eventos.Horarios_idHorarios = Horarios.idHorarios
        INNER JOIN Materias ON Materias.Horarios_idHorarios = Horarios.idHorarios;
      ''');
    } catch (error) {
      print(
          'Error al obtener los eventos con el horario y el nombre de la materia: $error');
      throw 'Error al obtener los eventos con el horario y el nombre de la materia: $error';
    }
  }

  Future<List<Map<String, dynamic>>> getEventosDeMateriaConHorario(
      String idMateria) async {
    try {
      Database db = await instance.database;
      return await db.rawQuery('''
        SELECT Materias.nombre_materia, Horarios.Horario, Eventos.nombre_evento
        FROM Eventos
        INNER JOIN Horarios ON Eventos.Horarios_idHorarios = Horarios.idHorarios
        INNER JOIN Materias ON Materias.Horarios_idHorarios = Horarios.idHorarios
        WHERE Materias.idMaterias = ?;
      ''', [idMateria]);
    } catch (error) {
      print(
          'Error al obtener los eventos de la materia con el horario: $error');
      throw 'Error al obtener los eventos de la materia con el horario: $error';
    }
  }
}
