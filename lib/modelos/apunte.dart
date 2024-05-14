// lib/modelos/apunte.dart

class Apunte {
  final int id;
  final String titulo;
  final String contenido;
  final DateTime fecha;
  final String materia; 
  bool isSelected;

  Apunte({
    this.id = 0,
    required this.titulo,
    required this.contenido,
    required this.fecha,
    required this.materia, 
    this.isSelected = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'contenido': contenido,
      'fecha': fecha.toIso8601String(),
      'materia': materia, 
      'isSelected': isSelected ? 1 : 0, // Convertir a 1 o 0
    };
  }

  factory Apunte.fromJson(Map<String, dynamic> json) {
    return Apunte(
      id: json['id'],
      titulo: json['titulo'],
      contenido: json['contenido'],
      fecha: DateTime.parse(json['fecha']),
      materia: json['materia'], 
      isSelected: json['isSelected'] == 1 ? true : false, // Convertir de 1 o 0 a booleano
    );
  }

}

