import 'package:flutter/material.dart';
import '../models/tarea.dart'; // Importamos el modelo de Tarea
import 'tarea_card.dart'; // Importamos el widget de tarjeta de tarea

class TareasList extends StatelessWidget {
  final List<Tarea> tareas; // Cambiamos el tipo de la lista a Tarea
  final Function(Tarea, bool) onTareaSelected;

  TareasList({required this.tareas, required this.onTareaSelected});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tareas.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0),
            child: Text(
              'Tareas:', // Cambiamos el texto a "Tareas"
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        } else {
          final tarea = tareas[index - 1]; // Accedemos a la tarea en lugar del apunte
          return Column(
            children: [
              TareaCard( // Utilizamos el widget de tarjeta de tarea
                tarea: tarea,
                onTap: () {
                  onTareaSelected(tarea, !tarea.isSelected);
                },
                onLongPress: () {
                  onTareaSelected(tarea, !tarea.isSelected);
                },
                isSelected: tarea.isSelected,
              ),
              Divider( // Separador entre tareas
                color: Colors.grey.withOpacity(0.5),
                thickness: 1, 
              ),
            ],
          );
        }
      },
    );
  }
}

