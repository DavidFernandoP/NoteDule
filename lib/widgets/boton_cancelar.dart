//lib\widgets\boton_cancelar.dart


import 'package:flutter/material.dart';

class BotonCancelar extends StatelessWidget {
  final VoidCallback? onPressed; // Define onPressed como un VoidCallback

  BotonCancelar({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed, // Usa onPressed aquí
      child: Text('Cancelar'),
    );
  }
}