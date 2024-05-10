import 'package:flutter/material.dart';

class BotonCancelar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.clear, color: Colors.white),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
