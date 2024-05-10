// lib/models/tarea.dart
class Tarea {
  final String titulo;
  final String contenido;
  final DateTime fecha;
  bool isSelected; 

  Tarea({required this.titulo, required this.contenido, required this.fecha, this.isSelected = false});
}

