//lib\widgets\boton_guardar.dart
import 'package:flutter/material.dart';

class BotonGuardar extends StatelessWidget {
  final VoidCallback? onPressed; 

  BotonGuardar({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed, 
      child: Text('Guardar'),
    );
  }
}