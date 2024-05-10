import 'package:flutter/material.dart';
import '../models/tarea.dart'; // Importamos el modelo de Tarea

class TareaCard extends StatelessWidget {
  final Tarea tarea; // Cambiamos el tipo de la propiedad a Tarea
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final bool isSelected;

  TareaCard({required this.tarea, required this.onTap, required this.onLongPress, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? Colors.grey[200] : Colors.transparent,
      child: ListTile(
        title: Text(
          tarea.titulo, // Accedemos al título de la tarea en lugar del apunte
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          tarea.fecha.toString(), // Accedemos a la fecha de la tarea en lugar del apunte
          style: TextStyle(color: Colors.grey),
        ),
        onTap: onTap,
        onLongPress: onLongPress,
      ),
    );
  }
}
