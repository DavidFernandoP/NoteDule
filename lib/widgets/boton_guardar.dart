//lib\widgets\boton_guardar.dart
import 'package:flutter/material.dart';

class BotonGuardar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.check, color: Colors.white),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
