// lib\widgets\boton_guardar.dart

import 'package:flutter/material.dart';
import '../modelos/apunte.dart';
import '../servicios/database_helper.dart';

class BotonGuardar extends StatelessWidget {
  final String materiaActual;
  final TextEditingController tituloController;
  final TextEditingController contenidoController;
  final TextEditingController fechaController;
  final VoidCallback? onPressed;

  BotonGuardar({
    required this.materiaActual,
    required this.tituloController,
    required this.contenidoController,
    required this.fechaController,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        _guardarApunte(
          context,
          materiaActual,
          tituloController.text,
          contenidoController.text,
          fechaController.text,
        );
      },
      child: Text('Guardar'),
    );
  }

  Future<void> _guardarApunte(
    BuildContext context,
    String materia,
    String titulo,
    String contenido,
    String fechaString,
  ) async {
    try {
      // Parsear la fecha de String a DateTime
      DateTime fecha = DateTime.parse(fechaString);

      Apunte nuevoApunte = Apunte(
        id: 0,
        titulo: titulo,
        contenido: contenido,
        fecha: fecha, // Utiliza el DateTime parseado
        materia: materia, // Asigna la materia actual al apunte
      );

      int result = await DatabaseHelper.addApunte(nuevoApunte);
      if (result > 0) {
        // Éxito
        print('Apunte guardado correctamente.');
        Navigator.pop(context);
      } else {
        // Falla
        print('No se pudo guardar el apunte.');
      }
    } catch (error) {
      print('Error al guardar el apunte: $error');
    }
  }
}
