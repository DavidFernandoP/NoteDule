import 'package:flutter/material.dart';
import 'package:notedule/sistema/globals.dart';
import '../screens/tareas_form_screen.dart'; // Importamos la pantalla de formulario de tareas

class BotonNuevaTarea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.create, color: globals.blanco), 
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => TareasFormScreen(), // Utilizamos la pantalla de formulario de tareas
        );
      },
    );
  }
}
