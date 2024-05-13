// lib/widgets/boton_nuevo_apunte.dart

import 'package:flutter/material.dart';
import 'package:notedule/sistema/globals.dart';
import '../screens/notas_form_screen.dart';

class BotonNuevoApunte extends StatelessWidget {
  final String materiaActual;

  BotonNuevoApunte({required this.materiaActual});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.create, color: globals.blanco), 
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => NotasFormScreen(materiaActual: materiaActual),
        );
      },
    );
  }
}