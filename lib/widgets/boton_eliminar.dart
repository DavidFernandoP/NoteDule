// lib/widgets/boton_eliminar.dart

import 'package:flutter/material.dart';
import 'package:notedule/sistema/globals.dart';
import '../modelos/apunte.dart';
import '../screens/eliminar_apuntes_screen.dart';

class BotonEliminar extends StatelessWidget {
  final List<Apunte> apuntes;
  final String materiaActual;

  BotonEliminar({
    required this.apuntes,
    required this.materiaActual,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton( 
      icon: Icon(Icons.delete),
      color: globals.blanco,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EliminarApuntesScreen(
              apuntes: apuntes,
              materiaActual: materiaActual,
            ),
          ),
        );
      },
    );
  }
}
