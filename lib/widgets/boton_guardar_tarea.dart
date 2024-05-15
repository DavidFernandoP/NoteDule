import 'package:flutter/material.dart';
import '../modelos/tarea.dart';
import '../servicios/database_helper.dart';

class BotonGuardar extends StatelessWidget {
  final BuildContext context;
  final TextEditingController tituloController;
  final TextEditingController contenidoController;
  final TextEditingController fechaController;
  final VoidCallback? onPressed;

  BotonGuardar({
    required this.context,
    required this.tituloController,
    required this.contenidoController,
    required this.fechaController,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        _guardarTarea(
          tituloController.text,
          contenidoController.text,
          fechaController.text,
        );
      },
      child: Text('Guardar'),
    );
  }

  Future<void> _guardarTarea(
    String titulo,
    String contenido,
    String fechaString,
  ) async {
    try {
      // Parsear la fecha de String a DateTime
      DateTime fecha = DateTime.parse(fechaString);

      Tarea nuevaTarea = Tarea(
        titulo: titulo,
        contenido: contenido,
        fecha: fecha, // Utiliza el DateTime parseado
      );

      // Lógica para guardar la tarea en la base de datos
      int result = await DatabaseHelper.addTarea(nuevaTarea);
      if (result > 0) {
        // Éxito
        print('Tarea guardada correctamente.');
        Navigator.pop(context);
      } else {
        // Falla
        print('No se pudo guardar la tarea.');
      }
    } catch (error) {
      print('Error al guardar la tarea: $error');
    }
  }
}
