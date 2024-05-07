// lib/widgets/boton_eliminar.dart
import 'package:flutter/material.dart';
import '../modelos/apunte.dart';
import '../screens/eliminar_apuntes_screen.dart';

class BotonEliminar extends StatelessWidget {
  final List<Apunte> apuntes;
  BotonEliminar({required this.apuntes});

  @override
  Widget build(BuildContext context) {
    return IconButton( 
      icon: Icon(Icons.delete),
      color: Colors.white,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EliminarApuntesScreen(apuntes: apuntes),
          ),
        );
      },
    );
  }
}
