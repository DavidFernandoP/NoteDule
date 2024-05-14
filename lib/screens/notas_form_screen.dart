// lib/screens/notas_form_screen.dart
import 'package:flutter/material.dart';
import '../widgets/boton_cancelar.dart';
import '../widgets/boton_guardar.dart';
import '../servicios/database_helper.dart';
import '../modelos/apunte.dart';
import '../sistema/globals.dart';

class NotasFormScreen extends StatefulWidget {
  final String materiaActual;

  NotasFormScreen({required this.materiaActual});

  @override
  _NotasFormScreenState createState() => _NotasFormScreenState();
}

class _NotasFormScreenState extends State<NotasFormScreen> {
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
        backgroundColor: globals.negro,
        title: Text(
          'Nuevo Apunte - ${widget.materiaActual}',
          style: TextStyle(color: globals.blanco),
        ),
      ),
      body: Container(
        color: globals.negro,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _tituloController,
              style: TextStyle(color: globals.blanco),
              decoration: InputDecoration(
                labelText: 'Título',
                labelStyle: TextStyle(color: globals.blanco),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _contenidoController,
              style: TextStyle(color: globals.blanco),
              decoration: InputDecoration(
                labelText: 'Contenido',
                labelStyle: TextStyle(color: globals.blanco),
                border: OutlineInputBorder(),
              ),
              maxLines: null, // Para permitir múltiples líneas de texto
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _fechaController,
              style: TextStyle(color: globals.blanco),
              decoration: InputDecoration(
                labelText: 'Fecha',
                labelStyle: TextStyle(color: globals.blanco),
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
        color: globals.negro,
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
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _guardarApunte(BuildContext context, String materia) async {
    try {
      String titulo = _tituloController.text;
      String contenido = _contenidoController.text;
      String fechaString = _fechaController.text;

      // Parsear la fecha de String a DateTime
      DateTime fecha = DateTime.parse(fechaString);

      Apunte nuevoApunte = Apunte(
        id: 0,
        titulo: titulo,
        contenido: contenido,
        fecha: fecha, // Utiliza el DateTime parseado
        materia: materia, // Asigna la materia actual al apunte
      );

      int result = await DatabaseHelper.addApunte(nuevoApunte);
      if (result > 0) {
        // Éxito
        print('Apunte guardado correctamente.');
        Navigator.pop(context);
      } else {
        // Falla
        print('No se pudo guardar el apunte.');
      }
    } catch (error) {
      print('Error al guardar el apunte: $error');
    }
  }
}
