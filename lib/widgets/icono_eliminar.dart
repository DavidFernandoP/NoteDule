//lib\widgets\boton_eliminar.dart

import 'package:flutter/material.dart';

class IconoEliminar extends StatelessWidget {
  final VoidCallback onPressed;

  IconoEliminar({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.close, color: Colors.white),
      onPressed: onPressed,
    );
  }
}
