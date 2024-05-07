import 'package:flutter/material.dart';

class Carga extends StatelessWidget {
  final Color negro;
  final Color blanco;

  Carga({required this.negro, required this.blanco});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: negro,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png', // Ruta de tu imagen de logo
              width: 100, // Ancho de la imagen
              height: 100, // Alto de la imagen
            ),
            SizedBox(height: 20),
            Text(
              'NOTEDULE',
              style: TextStyle(
                color: blanco,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Hecho para ti\nHecho por ti',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: blanco,
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}