// lib/models/apunte.dart
class Apunte {
  final int? id;
  final String titulo;
  final String contenido;
  final DateTime fecha;
  final bool isSelected; 

  const Apunte({
    required this.titulo, 
    required this.contenido, 
    required this.fecha, 
    this.isSelected = false,
    this.id
  });

  factory Apunte.fromJson(Map<String,dynamic> json) => Apunte(
    id: json['id'],
    titulo: json['titulo'],
    contenido: json['contenido'],
    fecha: json['fecha'],
    isSelected: json['isSelected'],
  );

  Map<String,dynamic> toJson() => {
    'id': id,
    'titulo': titulo,
    'contenido': contenido,
    'fecha': fecha,
    'isSelected': isSelected,
  };
}

