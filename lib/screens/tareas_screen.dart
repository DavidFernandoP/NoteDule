import 'package:flutter/material.dart';
import '../models/tarea.dart';
import '../widgets/tareas_list.dart'; // Importamos el widget de lista de tareas
import '../widgets/boton_volver.dart';
import '../widgets/boton_nuevo_tarea.dart'; // Importamos el botón para añadir nueva tarea
import '../widgets/boton_eliminar.dart';

class TareasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Lista de tareas de prueba
    List<Tarea> tareas = [
      Tarea(
        titulo: 'Primera tarea',
        contenido: 'Contenido de la primera tarea...',
        fecha: DateTime.now(),
      ),
      Tarea(
        titulo: 'Segunda tarea',
        contenido: 'Contenido de la segunda tarea...',
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
                'Proyecto Integrador 3',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: TareasList( // Utilizamos el widget de lista de tareas
              tareas: tareas,
              onTareaSelected: (tarea, selected) {
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
            BotonNuevaTarea(), // Utilizamos el botón para añadir nueva tarea
            BotonEliminar(tareas: tareas), // Pasamos la lista de tareas al botón de eliminar
          ],
        ),
      ),
    );
  }
}
