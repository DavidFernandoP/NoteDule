// lib/screens/notas_screen.dart
import 'package:flutter/material.dart';
import 'package:notedule/sistema/globals.dart';
import '../modelos/apunte.dart';
import '../widgets/notas_list.dart';
import '../widgets/boton_volver.dart';
import '../widgets/boton_nuevo_apunte.dart';
import '../widgets/boton_eliminar.dart';

class NotasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Lista de apuntes de prueba
    List<Apunte> apuntes = [
      Apunte(
        titulo: 'Primer apunte',
        contenido: 'Contenido del primer apunte...',
        fecha: DateTime.now(),
      ),
      Apunte(
        titulo: 'Segundo apunte',
        contenido: 'Contenido del segundo apunte...',
        fecha: DateTime.now(),
      ),

    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'NOTEDULE',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                globals.materiaActual,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: NotasList(
              apuntes: apuntes,
              onApunteSelected: (apunte, selected) {
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BotonVolver(),
            BotonNuevoApunte(),
            BotonEliminar(apuntes: apuntes), 
          ],
        ),
      ),
    );
  }
}

