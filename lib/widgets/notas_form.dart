// lib/widgets/notas_form.dart

import 'package:flutter/material.dart';
import 'package:notedule/servicios/database_helper.dart';
import 'package:notedule/modelos/apunte.dart';

class NotasForm extends StatefulWidget {
  final String materiaActual;

  NotasForm({required this.materiaActual});

  @override
  _NotasFormState createState() => _NotasFormState();
}

class _NotasFormState extends State<NotasForm> {
  TextEditingController _tituloController = TextEditingController();
  TextEditingController _contenidoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _tituloController,
            decoration: InputDecoration(labelText: 'Título'),
          ),
          TextField(
            controller: _contenidoController,
            decoration: InputDecoration(labelText: 'Contenido'),
            maxLines: null,
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: _guardarApunte,
                child: Text('Guardar'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _guardarApunte() async {
    String titulo = _tituloController.text;
    String contenido = _contenidoController.text;

    // Obtiene la fecha actual
    DateTime fechaActual = DateTime.now();

    // Crea un nuevo objeto Apunte con los datos del formulario y la fecha actual
    Apunte nuevoApunte = Apunte(
      titulo: titulo,
      contenido: contenido,
      fecha: fechaActual, // Agrega la fecha actual
      materia: widget.materiaActual,
    );

    try {
      // Inserta el nuevo apunte en la base de datos
      await DatabaseHelper.addApunte(nuevoApunte);

      // Después de guardar, cierra el formulario
      Navigator.pop(context);
    } catch (error) {
      // Maneja cualquier error que ocurra durante el proceso de guardado
      print('Error al guardar el apunte: $error');
      // Puedes mostrar un mensaje de error al usuario si lo deseas
      // También puedes agregar una lógica para manejar errores de otra manera
    }
  }
}
