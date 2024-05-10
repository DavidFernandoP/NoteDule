import 'package:flutter/material.dart';
import '../screens/tareas_form_screen.dart'; // Importamos la pantalla de formulario de tareas

class BotonNuevaTarea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.create, color: Colors.white), 
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => TareasFormScreen(), // Utilizamos la pantalla de formulario de tareas
        );
      },
    );
  }
}
