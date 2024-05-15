// lib/models/tarea.dart
class Tarea {
  final String titulo;
  final String contenido;
  final DateTime fecha;
  bool isSelected; 

  Tarea({
    required this.titulo,
    required this.contenido,
    required this.fecha,
    this.isSelected = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'contenido': contenido,
      'fecha': fecha.toIso8601String(),
      'isSelected': isSelected ? 1 : 0, // Convertir a 1 o 0
    };
  }

  factory Tarea.fromJson(Map<String, dynamic> json) {
    return Tarea(
      titulo: json['titulo'],
      contenido: json['contenido'],
      fecha: DateTime.parse(json['fecha']),
      isSelected: json['isSelected'] == 1 ? true : false, // Convertir de 1 o 0 a booleano
    );
  }
}
