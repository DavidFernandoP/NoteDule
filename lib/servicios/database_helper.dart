//lib\servicios\database_helper.dart
import 'package:notedule/modelos/materia_modelo.dart';
import 'package:notedule/modelos/apunte.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:notedule/modelos/tarea.dart';
import 'package:flutter/material.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "baseDatos.db";
  // Define una instancia estática de DatabaseHelper
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  // Constructor privado para evitar que se puedan crear instancias directamente
  DatabaseHelper._internal();

  // Método estático para acceder a la instancia única de DatabaseHelper
  static DatabaseHelper get instance => _instance;

  static Future<Database> _getDB() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE Materia(id INTEGER PRIMARY KEY, nombre TEXT NOT NULL, color TEXT NOT NULL, dia TEXT NOT NULL, inicio TEXT NOT NULL, fin TEXT NOT NULL);");
        await db.execute(
          "CREATE TABLE Apuntes(id INTEGER PRIMARY KEY, materia TEXT NOT NULL, titulo TEXT NOT NULL, fecha DATE NOT NULL, contenido TEXT NOT NULL, isSelected TEXT NOT NULL);",
        ); /*
          await db.execute(
              "CREATE TABLE Tareas(id INTEGER PRIMARY KEY, materia TEXT NOT NULL, titulo TEXT NOT NULL, fecha DATE NOT NULL, contenido TEXT NOT NULL, check TEXT NOT NULL);",
          );*/
      },
      version: _version,
    );
  }

//---------------------Metodos para materias------------------------------------
  static Future<int> addNote(Materia note) async {
    final db = await _getDB();
    return await db.insert("Materia", note.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateNote(Materia note) async {
    final db = await _getDB();
    return await db.update("Materia", note.toJson(),
        where: 'id = ?',
        whereArgs: [note.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteNote(Materia note) async {
    final db = await _getDB();
    return await db.delete(
      "Materia",
      where: 'nombre = ?',
      whereArgs: [note.nombre],
    );
  }

  static Future<void> deleteAllNotes() async {
    final db = await _getDB();
    await db.delete("Materia");
  }

  static Future<List<Materia>?> getAllNotes() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("Materia");

    if (maps.isEmpty) {
      return _getDefaultMaterias();

      //return null;
    }

    return List.generate(maps.length, (index) => Materia.fromJson(maps[index]));
  }

  static Future<List<Materia>> _getDefaultMaterias() async {
    // Aquí defines tus datos de ejemplo
    List<Materia> defaultMaterias = [
      Materia(
        nombre: "Matemáticas",
        color: "00FF00", // Color verde
        dia: "LUN",
        inicio: "8",
        fin: "10",
      ),
      Materia(
        nombre: "Historia",
        color: "FF0000", // Color rojo
        dia: "JUE",
        inicio: "12",
        fin: "13",
      ),
      // Puedes agregar más materias según sea necesario
    ];

    // Insertar datos de ejemplo en la base de datos
    for (var materia in defaultMaterias) {
      await addNote(materia);
    }

    return defaultMaterias;
  }

  //---------------------Metodos para apuntes-------------------------
  static Future<int> addApunte(Apunte apunte) async {
    final db = await _getDB();
    return await db.insert("Apuntes", apunte.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateApunte(Apunte apunte) async {
    final db = await _getDB();
    return await db.update("Apuntes", apunte.toJson(),
        where: 'titulo = ?',
        whereArgs: [apunte.titulo],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteApunte(Apunte apunte) async {
    final db = await _getDB();
    return await db.delete(
      "Apuntes",
      where: 'titulo = ?',
      whereArgs: [apunte.titulo],
    );
  }

  static Future<List<Map<String, dynamic>>> getApuntes(String materia) async {
    final db = await _getDB();
    final List<Map<String, dynamic>> apuntes = await db.query(
      'Apuntes',
      where: 'materia = ?',
      whereArgs: [materia],
    );
    print('Apuntes de la materia $materia: $apuntes');
    return apuntes;
  }

  Future<void> insertarDatosPrueba() async {
    // Crear apuntes de prueba para la materia "Historia"
    List<Apunte> apuntesHistoria = [
      Apunte(
        materia: "Historia",
        titulo: 'Apunte Historia 1',
        fecha: DateTime.now(),
        contenido: 'Contenido del Apunte de Historia 1',
      ),
      Apunte(
        materia: "Historia",
        titulo: 'Apunte Historia 2',
        fecha: DateTime.now(),
        contenido: 'Contenido del Apunte de Historia 2',
      ),
      Apunte(
        materia: "Historia",
        titulo: 'Apunte Historia 3',
        fecha: DateTime.now(),
        contenido: 'Contenido del Apunte de Historia 3',
      ),
    ];

    // Insertar los apuntes de prueba para la materia "Historia"
    for (var apunte in apuntesHistoria) {
      await addApunte(apunte);
    }

    // Crear apuntes de prueba para la materia "Matemáticas"
    List<Apunte> apuntesMatematicas = [
      Apunte(
        materia: "Matemáticas",
        titulo: 'Apunte Matemáticas 1',
        fecha: DateTime.now(),
        contenido: 'Contenido del Apunte de Matemáticas 1',
      ),
      Apunte(
        materia: "Matemáticas",
        titulo: 'Apunte Matemáticas 2',
        fecha: DateTime.now(),
        contenido: 'Contenido del Apunte de Matemáticas 2',
      ),
      Apunte(
        materia: "Matemáticas",
        titulo: 'Apunte Matemáticas 3',
        fecha: DateTime.now(),
        contenido: 'Contenido del Apunte de Matemáticas 3',
      ),
    ];

    // Insertar los apuntes de prueba para la materia "Matemáticas"
    for (var apunte in apuntesMatematicas) {
      await addApunte(apunte);
    }
  }

  /*
  //----------------------Metodos para tareas--------------------------
  static Future<int> addTarea(Tarea tarea) async {
    final db = await _getDB();
    return await db.insert("Tareas", tarea.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateTarea(Tarea tarea) async {
    final db = await _getDB();
    return await db.update("Tareas", tarea.toJson(),
        where: 'titulo = ?',
        whereArgs: [tarea.titulo],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteTarea(Tarea tarea) async {
    final db = await _getDB();
    return await db.delete(
      "Tareas",
      where: 'titulo = ?',
      whereArgs: [tarea.titulo],
    );
  }

  static Future<List<Map<String, dynamic>>> getTarea(String materia) async {
    final db = await _getDB();
    return await db.query(
      'Tareas',
      where: 'materia = ?',
      whereArgs: [materia],
    );
  }*/
}
