import 'package:notedule/modelos/materia_modelo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "baseDatos.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE Materia(id INTEGER PRIMARY KEY, nombre TEXT NOT NULL, color TEXT NOT NULL, dia TEXT NOT NULL, inicio TEXT NOT NULL, fin TEXT NOT NULL);"),
        version: _version);
  }

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
}