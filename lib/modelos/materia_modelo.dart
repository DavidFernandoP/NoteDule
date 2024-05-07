class Materia{
  final int? id;
  final String nombre;
  final String color;
  final String dia;
  final String inicio;
  final String fin;

  const Materia({
    required this.nombre, 
    required this.color,
    required this.dia,
    required this.inicio,
    required this.fin,
    this.id
  });

  factory Materia.fromJson(Map<String,dynamic> json) => Materia(
    id: json['id'],
    nombre: json['nombre'],
    color: json['color'],
    dia: json['dia'],
    inicio: json['inicio'],
    fin: json['fin']
  );

  Map<String,dynamic> toJson() => {
    'id': id,
    'nombre': nombre,
    'color': color,
    'dia': dia,
    'inicio': inicio,
    'fin': fin
  };
}