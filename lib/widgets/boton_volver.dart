// lib/widgets/boton_volver.dart
import 'package:flutter/material.dart';
import 'package:notedule/sistema/globals.dart';

class BotonVolver extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: globals.blanco),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}