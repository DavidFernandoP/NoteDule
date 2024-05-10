import 'package:flutter/material.dart';
import '../models/tarea.dart'; // Importamos el modelo de Tarea
import '../screens/eliminar_tareas_screen.dart'; // Importamos la pantalla de eliminar tareas

class BotonEliminar extends StatelessWidget {
  final List<Tarea> tareas; // Cambiamos el tipo de la lista a Tarea
  BotonEliminar({required this.tareas});

  @override
  Widget build(BuildContext context) {
    return IconButton( 
      icon: Icon(Icons.delete),
      color: Colors.white,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EliminarTareasScreen(tareas: tareas), // Pasamos la lista de tareas a la pantalla de eliminar tareas
          ),
        );
      },
    );
  }
}

