import 'package:flutter/material.dart';
import '../widgets/boton_cancelar.dart';
import '../widgets/boton_guardar.dart';
import '../servicios/database_helper.dart';
import '../modelos/tarea.dart';
import '../system/globals.dart';

class TareasFormScreen extends StatefulWidget {
  final String materiaActual;

  TareasFormScreen({required this.materiaActual});

  @override
  _TareasFormScreenState createState() => _TareasFormScreenState();
}

class _TareasFormScreenState extends State<TareasFormScreen> {
  late TextEditingController _tituloController;
  late TextEditingController _contenidoController;
  late TextEditingController _fechaController;

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController();
    _contenidoController = TextEditingController();
    _fechaController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Globals.negro,
        title: Text(
          'Nueva Tarea - ${widget.materiaActual}',
          style: TextStyle(color: Globals.blanco),
        ),
      ),
      body: Container(
        color: Globals.negro,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _tituloController,
              style: TextStyle(color: Globals.blanco),
              decoration: InputDecoration(
                labelText: 'Título',
                labelStyle: TextStyle(color: Globals.blanco),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _contenidoController,
              style: TextStyle(color: Globals.blanco),
              decoration: InputDecoration(
                labelText: 'Contenido',
                labelStyle: TextStyle(color: Globals.blanco),
                border: OutlineInputBorder(),
              ),
              maxLines: null, // Para permitir múltiples líneas de texto
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _fechaController,
              style: TextStyle(color: Globals.blanco),
              decoration: InputDecoration(
                labelText: 'Fecha',
                labelStyle: TextStyle(color: Globals.blanco),
                border: OutlineInputBorder(),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  _fechaController.text = pickedDate.toString();
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Globals.negro,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BotonCancelar(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            BotonGuardar(
              materiaActual: widget.materiaActual,
              tituloController: _tituloController,
              contenidoController: _contenidoController,
              fechaController: _fechaController,
              onPressed: () {
                // Aquí puedes manejar la lógica del botón guardar si es necesario
                _guardarTarea(context, widget.materiaActual);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _guardarTarea(BuildContext context, String materia) async {
    try {
      String titulo = _tituloController.text;
      String contenido = _contenidoController.text;
      String fechaString = _fechaController.text;

      // Parsear la fecha de String a DateTime
      DateTime fecha = DateTime.parse(fechaString);

      Tarea nuevaTarea = Tarea(
        id: 0,
        titulo: titulo,
        contenido: contenido,
        fecha: fecha, // Utiliza el DateTime parseado
        materia: materia, // Asigna la materia actual a la tarea
      );

      int result = await DatabaseHelper.addTarea(nuevaTarea);
      if (result > 0) {
        // Éxito
        print('Tarea guardada correctamente.');
        Navigator.pop(context);
      } else {
        // Falla
        print('No se pudo guardar la tarea.');
      }
    } catch (error) {
      print('Error al guardar la tarea: $error');
    }
  }
}
