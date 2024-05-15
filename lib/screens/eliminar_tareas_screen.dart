import 'package:flutter/material.dart';
import '../modelos/tarea.dart';
import '../widgets/icono_eliminar.dart';
import '../widgets/boton_volver.dart';
import '../widgets/boton_eliminar.dart';
import '../servicios/database_helper.dart';
import '../sistema/globals.dart';

class EliminarTareasScreen extends StatefulWidget {
  final List<Tarea> tareas;
  final String materiaActual;

  EliminarTareasScreen({
    required this.tareas,
    required this.materiaActual,
  });

  @override
  _EliminarTareasScreenState createState() => _EliminarTareasScreenState();
}

class _EliminarTareasScreenState extends State<EliminarTareasScreen> {
  List<Tarea> _tareas = [];

  @override
  void initState() {
    super.initState();
    _tareas = List.from(widget.tareas);
  }

  void _eliminarTarea(int index) async {
    Tarea tarea = _tareas[index];
    try {
      await DatabaseHelper.deleteTarea(tarea);
    } catch (error) {
      print('Error al eliminar la tarea de la base de datos: $error');
      return;
    }
    setState(() {
      _tareas.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Eliminar Tareas - ${widget.materiaActual}',
          style: TextStyle(
            color: Globals.blanco,
          ),
        ),
        backgroundColor: Globals.negro,
      ),
      backgroundColor: Globals.negro,
      body: ListView.builder(
        itemCount: _tareas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              _tareas[index].titulo,
              style: TextStyle(color: Globals.blanco),
            ),
            subtitle: Text(
              _tareas[index].fecha.toString(),
              style: TextStyle(color: Globals.gris),
            ),
            trailing: IconoEliminar(
              onPressed: () {
                _eliminarTarea(index);
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Globals.negro,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BotonVolver(),
            BotonEliminar(
              tareas: _tareas,
              materiaActual: widget.materiaActual,
            ),
          ],
        ),
      ),
    );
  }
}
