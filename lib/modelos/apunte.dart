// lib/models/apunte.dart
class Apunte {
  final String titulo;
  final String contenido;
  final DateTime fecha;
  bool isSelected; 

  Apunte({required this.titulo, required this.contenido, required this.fecha, this.isSelected = false});
}
