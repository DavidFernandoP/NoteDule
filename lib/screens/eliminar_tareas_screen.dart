import 'package:flutter/material.dart';
import '../modelos/tarea.dart';
import '../widgets/icono_eliminar.dart';
import '../widgets/boton_volver.dart';
import '../widgets/boton_eliminar_tarea.dart';
import '../servicios/database_helper.dart'; // Importamos el archivo donde está definido el método deleteTarea

class EliminarTareasScreen extends StatelessWidget {
  final List<Tarea> tareas;

  EliminarTareasScreen({required this.tareas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: Container(),
        title: Center(
          child: Text(
            'NOTEDULE',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black,
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
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tareas.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                    child: Text(
                      'Tareas:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else {
                  final tarea = tareas[index - 1];
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          tarea.titulo,
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          tarea.fecha.toString(),
                          style: TextStyle(color: Colors.grey),
                        ),
                        trailing: IconoEliminar(
                          onPressed: () {
                            _eliminarTarea(context, tarea); // Llamamos a la función para eliminar la tarea
                          },
                        ),
                      ),
                      Divider( 
                        color: Colors.grey.withOpacity(0.5), 
                        thickness: 1, 
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BotonVolver(),
            BotonEliminar(tareas: tareas),
          ],
        ),
      ),
    );
  }

  // Método para eliminar una tarea
  void _eliminarTarea(BuildContext context, Tarea tarea) async {
    // Llamar al método deleteTarea para eliminar la tarea de la base de datos
    final resultado = await DatabaseHelper.deleteTarea(tarea);

    // Mostrar un diálogo con el resultado de la operación
    if (resultado != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Éxito'),
          content: Text('La tarea se eliminó correctamente.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Hubo un error al eliminar la tarea.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
